import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:protagonistas_gta/protagonistas_gta.dart';

// Colores de prueba. Los definimos aquí a propósito: así las pruebas no
// dependen de los colores internos del paquete y comprueban justo lo que
// nos interesa, que el componente respeta el color que le damos.
const _magenta = Color(0xFFFF2D87);
const _cyan = Color(0xFF00F0FF);

// Dos personajes de prueba, uno femenino y otro masculino.
// Jason lleva iconoInterior (el monigote) y la etiqueta en masculino,
// para poder comprobar esas dos opciones.
const _lucia = Protagonista(
  id: 'lucia',
  nombre: 'Lucía',
  rol: 'Protagonista',
  icono: Icons.account_box,
  colorAcento: _magenta,
);

const _jason = Protagonista(
  id: 'jason',
  nombre: 'Jason',
  rol: 'Protagonista',
  icono: Icons.shield,
  iconoInterior: Icons.person,
  colorAcento: _cyan,
  etiquetaActiva: 'ACTIVO',
);

// Los widgets necesitan un MaterialApp y un Scaffold alrededor para poder
// dibujarse en una prueba. Esta función se lo pone, para no repetir lo
// mismo en cada test.
Widget _envolver(Widget hijo) => MaterialApp(home: Scaffold(body: hijo));

void main() {
  // ---------------------------------------------------------------------
  // Pruebas del componente completo (título + tarjetas)
  // ---------------------------------------------------------------------
  group('SelectorProtagonistas', () {
    // PRUEBA 1: lo más básico. Si esta falla, el componente ni siquiera
    // enseña lo que tiene que enseñar.
    testWidgets('muestra el título y los nombres', (tester) async {
      await tester.pumpWidget(_envolver(SelectorProtagonistas(
        protagonistas: const [_lucia, _jason],
        idActivo: 'lucia',
        onSeleccionado: (_) {},
      )));

      expect(find.text('PROTAGONISTAS'), findsOneWidget);
      expect(find.text('Lucía'), findsOneWidget);
      expect(find.text('Jason'), findsOneWidget);
    });

    // PRUEBA 2: la regla clave del componente es que solo puede haber UNA
    // tarjeta activa. Con Lucía activa debe salir "ACTIVA" una sola vez, y
    // nada de "ACTIVO" (la etiqueta de Jason).
    testWidgets('solo la tarjeta activa muestra la etiqueta', (tester) async {
      await tester.pumpWidget(_envolver(SelectorProtagonistas(
        protagonistas: const [_lucia, _jason],
        idActivo: 'lucia',
        onSeleccionado: (_) {},
      )));

      expect(find.text('ACTIVA'), findsOneWidget);
      expect(find.text('ACTIVO'), findsNothing);
    });

    // PRUEBA 3: caso límite. Si la app no dice quién está activo (idActivo
    // es null), no tiene que aparecer ninguna etiqueta ni petar nada.
    testWidgets('sin idActivo no hay ninguna etiqueta', (tester) async {
      await tester.pumpWidget(_envolver(SelectorProtagonistas(
        protagonistas: const [_lucia, _jason],
        onSeleccionado: (_) {},
      )));

      expect(find.text('ACTIVA'), findsNothing);
      expect(find.text('ACTIVO'), findsNothing);
    });

    // PRUEBA 4: aquí probamos el EVENTO. El "robot" toca la tarjeta de
    // Jason y miramos si el componente avisó a la app con el personaje
    // correcto. Es una de las más importantes, porque es lo único que
    // conecta el componente con el resto de la app.
    testWidgets('al pulsar una tarjeta llama a onSeleccionado con ese protagonista',
        (tester) async {
      Protagonista? elegido;
      await tester.pumpWidget(_envolver(SelectorProtagonistas(
        protagonistas: const [_lucia, _jason],
        idActivo: 'lucia',
        onSeleccionado: (p) => elegido = p,
      )));

      await tester.tap(find.text('Jason'));
      expect(elegido?.id, 'jason');
    });

    // PRUEBA 5: es la prueba de "la película completa". Simula lo que haría
    // una app de verdad: guarda quién está activo y, al recibir el aviso,
    // lo actualiza. Se comprueba que la etiqueta salta de Lucía a Jason.
    // El pumpAndSettle espera a que termine la animación del borde.
    testWidgets('la selección cambia al pulsar la otra tarjeta', (tester) async {
      String activo = 'lucia';
      await tester.pumpWidget(_envolver(StatefulBuilder(
        builder: (context, setState) => SelectorProtagonistas(
          protagonistas: const [_lucia, _jason],
          idActivo: activo,
          onSeleccionado: (p) => setState(() => activo = p.id),
        ),
      )));

      // Al empezar, la activa es Lucía.
      expect(find.text('ACTIVA'), findsOneWidget);

      await tester.tap(find.text('Jason'));
      await tester.pumpAndSettle();

      // Después de pulsar, la activa es Jason y Lucía se apaga.
      expect(find.text('ACTIVO'), findsOneWidget);
      expect(find.text('ACTIVA'), findsNothing);
    });
  });

  // ---------------------------------------------------------------------
  // Pruebas de una tarjeta suelta
  // ---------------------------------------------------------------------
  group('TarjetaProtagonista', () {
    // PRUEBA 6: comprueba el aspecto. La tarjeta activa de Jason debe tener
    // el borde cyan (su color de acento), no el magenta de Lucía. Esto
    // evita un fallo que ya nos pasó al montarlo: el borde salía siempre
    // magenta.
    testWidgets('la tarjeta activa usa el color de acento en el borde',
        (tester) async {
      await tester.pumpWidget(_envolver(
        const TarjetaProtagonista(protagonista: _jason, activa: true),
      ));

      final contenedor = tester.widget<AnimatedContainer>(
        find.byType(AnimatedContainer),
      );
      final borde = (contenedor.decoration as BoxDecoration).border as Border;
      expect(borde.top.color, _cyan);
    });

    // PRUEBA 7: el monigote dentro del escudo solo debe salir si se pide.
    // Jason lo lleva y Lucía no. Se comprueba contando cuántos iconos de
    // persona hay en pantalla en cada caso.
    testWidgets('muestra el icono interior solo si se indica', (tester) async {
      await tester.pumpWidget(_envolver(
        const TarjetaProtagonista(protagonista: _jason),
      ));
      expect(find.byIcon(Icons.person), findsOneWidget);

      await tester.pumpWidget(_envolver(
        const TarjetaProtagonista(protagonista: _lucia),
      ));
      expect(find.byIcon(Icons.person), findsNothing);
    });
  });

  // ---------------------------------------------------------------------
  // Pruebas de los datos de serie (Lucía y Jason ya preparados)
  // ---------------------------------------------------------------------
  group('Protagonista', () {
    // PRUEBA 8: la lista que trae el paquete de fábrica contiene a los dos
    // personajes del diseño y en el orden correcto.
    test('porDefecto trae a Lucía y Jason', () {
      expect(Protagonista.porDefecto.map((p) => p.id), ['lucia', 'jason']);
    });

    // PRUEBA 9: la etiqueta de Jason va en masculino y la de Lucía en
    // femenino. Es un detalle pequeño, pero fácil de romper sin darse cuenta.
    test('Jason usa la etiqueta en masculino', () {
      expect(Protagonista.jason.etiquetaActiva, 'ACTIVO');
      expect(Protagonista.lucia.etiquetaActiva, 'ACTIVA');
    });
  });
}