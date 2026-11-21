# protagonistas_gta

Un componente de Flutter que muestra a los **protagonistas** de la app
*GTA VI — Vice City Fan Companion*: una fila de tarjetas (por ejemplo, Lucía y
Jason) donde solo una puede estar **activa** a la vez. Al tocar una tarjeta, esa
pasa a ser la activa.

---

## ¿Cómo se ve y qué hace?

- Arriba, un título con una barra de color: **PROTAGONISTAS**.
- Debajo, una tarjeta por cada protagonista, con su icono, su nombre y su rol.
- La tarjeta **activa** destaca: su borde y su icono se iluminan con el color del
  personaje y aparece una etiqueta (**ACTIVA** o **ACTIVO**).
- Las demás tarjetas se ven apagadas.
- Al tocar una tarjeta apagada, pasa a ser la activa y la anterior se apaga.

Funciona en Android, en el navegador y en cualquier sitio donde funcione Flutter.
Se ha probado en Chrome y en un emulador de Pixel 8.

---

## ¿Qué es un «paquete»?

Un paquete es una **pieza independiente y reutilizable**. En lugar de copiar y
pegar el código de este componente en cada app, la app simplemente lo "enchufa" y
lo usa. Así, si el componente se mejora, se mejora para todas las apps a la vez.

---

## Qué necesitas antes de empezar

1. Tener **Flutter** instalado en el ordenador (puedes comprobarlo abriendo una
   terminal y escribiendo `flutter --version`).
2. Una app de Flutter donde quieras usar el componente.
3. La carpeta `protagonistas_gta` (la que contiene este archivo) guardada en tu
   ordenador.

---

## Instalación paso a paso

**Paso 1.** Coloca la carpeta `protagonistas_gta` junto a la carpeta de tu app.
Por ejemplo:

```
mi_proyecto/
├── mi_app/                 ← tu app
└── protagonistas_gta/      ← este paquete
```

**Paso 2.** Abre el archivo `pubspec.yaml` de **tu app** (no el del paquete) y
busca el apartado `dependencies:`. Añade estas dos líneas debajo de `flutter:`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  protagonistas_gta:
    path: ../protagonistas_gta
```

> Cuidado con los espacios del principio: `protagonistas_gta` debe quedar
> alineado con `flutter`, y `path` con dos espacios más. Si la carpeta del paquete
> está en otro sitio, cambia `../protagonistas_gta` por la ruta correcta.

**Paso 3.** Abre una terminal en la carpeta de tu app y escribe:

```bash
flutter pub get
```

Si no da ningún error, ya está instalado.

---

## Cómo usarlo

### La forma más rápida (con Lucía y Jason)

En el archivo de tu app donde quieras mostrarlo, escribe arriba del todo:

```dart
import 'package:protagonistas_gta/protagonistas_gta.dart';
```

Y después coloca el componente donde quieras que aparezca:

```dart
SelectorProtagonistas(
  protagonistas: Protagonista.porDefecto, // Lucía y Jason
  idActivo: idActivo,
  onSeleccionado: (p) => setState(() => idActivo = p.id),
)
```

### Ejemplo completo para copiar y pegar

Es una app mínima que funciona tal cual. Puedes pegarla en el archivo
`lib/main.dart` de una app nueva:

```dart
import 'package:flutter/material.dart';
import 'package:protagonistas_gta/protagonistas_gta.dart';

void main() => runApp(const MiApp());

class MiApp extends StatefulWidget {
  const MiApp({super.key});

  @override
  State<MiApp> createState() => _MiAppState();
}

class _MiAppState extends State<MiApp> {
  // Aquí guardamos quién está activo. Empieza Lucía.
  String idActivo = Protagonista.lucia.id;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFF0A0D1A), // fondo oscuro del diseño
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SelectorProtagonistas(
              protagonistas: Protagonista.porDefecto,
              idActivo: idActivo,
              onSeleccionado: (p) => setState(() => idActivo = p.id),
            ),
          ),
        ),
      ),
    );
  }
}
```

### ¿Qué significa cada parte?

- **`protagonistas`**: la lista de personajes que se muestran.
- **`idActivo`**: el identificador del personaje que está activo ahora mismo.
- **`onSeleccionado`**: lo que debe hacer la app cuando alguien toca una tarjeta.
  Aquí le decimos: «guarda que el nuevo activo es el que han tocado».

> **El error más común:** el componente **no recuerda** quién está activo, eso
> lo decide tu app. Si no actualizas `idActivo` dentro de `onSeleccionado` (como
> en el ejemplo, con `setState`), al tocar una tarjeta no pasará nada.

---

## Cómo personalizarlo

### Cambiar el título

```dart
SelectorProtagonistas(
  titulo: 'PERSONAJES',
  // ...
)
```

### Crear tus propios protagonistas

No tienes que usar a Lucía y Jason. Puedes definir los que quieras:

```dart
const nuevo = Protagonista(
  id: 'nuevo',                 // un nombre interno único, sin repetir
  nombre: 'Nuevo',             // lo que se ve en la tarjeta
  rol: 'Personaje secundario', // el texto pequeño bajo el nombre
  icono: Icons.star,           // el icono del círculo
  colorPersonaje: Colors.amber,   // el color cuando está activo
);
```

Y úsalo en la lista:

```dart
SelectorProtagonistas(
  protagonistas: [Protagonista.lucia, Protagonista.jason, nuevo],
  idActivo: idActivo,
  onSeleccionado: (p) => setState(() => idActivo = p.id),
)
```

### Opciones extra de cada protagonista

- **`iconoInterior`**: un segundo icono pequeño dentro del principal. Jason lo usa
  para llevar un monigote dentro del escudo.
- **`etiquetaActiva`**: el texto de la etiqueta. Por defecto pone `ACTIVA`; para un
  personaje masculino puedes poner `'ACTIVO'`.

---

## Referencia completa

### `SelectorProtagonistas`

El componente principal: título más fila de tarjetas.

| Parámetro | Qué es | ¿Obligatorio? |
|---|---|---|
| `protagonistas` | La lista de personajes a mostrar | Sí |
| `onSeleccionado` | Qué hacer cuando se toca una tarjeta | Sí |
| `idActivo` | El `id` del personaje activo. Si no pones ninguno, ninguna tarjeta está activa | No |
| `titulo` | El título de la sección. Por defecto: `PROTAGONISTAS` | No |

### `Protagonista`

Los datos de un personaje.

| Campo | Qué es | ¿Obligatorio? |
|---|---|---|
| `id` | Identificador único e interno (por ejemplo, `'lucia'`) | Sí |
| `nombre` | El nombre que se ve | Sí |
| `rol` | El texto pequeño bajo el nombre | Sí |
| `icono` | El icono principal del círculo | Sí |
| `colorPersonaje` | El color del icono, del borde y de la etiqueta cuando está activo | Sí |
| `iconoInterior` | Un icono pequeño dentro del principal | No |
| `etiquetaActiva` | El texto de la etiqueta activa. Por defecto: `ACTIVA` | No |

Datos de serie incluidos: `Protagonista.lucia`, `Protagonista.jason` y
`Protagonista.porDefecto` (la lista con los dos).

### `TarjetaProtagonista`

Una sola tarjeta, por si quieres usarla suelta. Recibe `protagonista`, `activa`
(sí/no) y `onTap` (qué hacer al tocarla). `SelectorProtagonistas` ya la usa por
dentro, así que normalmente no hace falta tocarla.

---

## Qué hacer si algo falla

| Lo que ves | Qué suele pasar | Solución |
|---|---|---|
| Error «Target of URI doesn't exist» o no encuentra `protagonistas_gta` | La ruta del `pubspec.yaml` está mal o falta el `pub get` | Revisa que `path:` apunte a la carpeta correcta y ejecuta `flutter pub get` |
| Error de versión («SDK version») al hacer `pub get` | Tu Flutter es más antiguo que el que pide el paquete | Actualiza con `flutter upgrade` o avisa para bajar la versión exigida en el `pubspec.yaml` del paquete |
| Al tocar una tarjeta no cambia nada | No estás actualizando `idActivo` | Mira el recuadro de «El error más común» más arriba |
| Franjas amarillas y negras en pantalla | Hay poco espacio para las tarjetas | Dale más ancho al componente o reduce el margen que lo rodea |
| La pantalla se ve toda blanca | El componente no pinta el fondo de la pantalla | Pon un fondo oscuro, como en el ejemplo completo |

---

## Qué hay dentro de la carpeta

```
protagonistas_gta/
├── lib/
│   ├── protagonistas_gta.dart        ← la "puerta de entrada" del paquete
│   └── src/                          ← el código interno
│       ├── protagonista.dart
│       ├── tarjeta_protagonista.dart
│       ├── selector_protagonistas.dart
│       └── colores_gta.dart
├── test/
│   └── protagonistas_gta_test.dart   ← las pruebas automáticas
├── pubspec.yaml                      ← la «ficha» del paquete
├── README.md                         ← este documento
├── CHANGELOG.md
└── LICENSE
```

Para usar el paquete basta con importar `protagonistas_gta.dart`. Todo lo que
está dentro de `src/` es interno y no hace falta tocarlo.

---

## Pruebas automáticas

El paquete incluye pruebas: un «robot» que abre el componente, lo toca como lo
haría una persona y comprueba que todo funciona. Si alguien cambia el código y
rompe algo, las pruebas fallan y avisan.

Para ejecutarlas, abre una terminal en la carpeta `protagonistas_gta` y escribe:

```bash
flutter test
```

Si todo va bien, verás el mensaje **`All tests passed!`**. Estas son las
comprobaciones principales:

- Aparecen el título y los nombres de los personajes.
- Solo la tarjeta activa muestra la etiqueta.
- Si no se indica ningún activo, no aparece ninguna etiqueta.
- Al tocar una tarjeta, la app recibe el personaje correcto.
- Al tocar la otra tarjeta, la selección cambia.
- El borde de la tarjeta activa usa el color del personaje.
- El icono pequeño interior solo aparece si se indica.
- Los datos de serie incluyen a Lucía y a Jason, y Jason usa «ACTIVO».

Para revisar además que el código está limpio, usa:

```bash
flutter analyze
```

Debe responder **`No issues found!`**.