import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gta_selector_card/gta_selector_card.dart';

void main() {
  testWidgets('al pulsar "III" cambia la etiqueta y se llama a onChanged',
      (tester) async {
    int? recibido;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: GtaSelectorCard(onChanged: (i) => recibido = i),
      ),
    ));

    // Por defecto está seleccionado VI
    expect(find.text('GTA VI'), findsOneWidget);

    // Pulsamos el círculo "III"
    await tester.tap(find.text('III'));
    await tester.pumpAndSettle();

    expect(recibido, 2); // índice de III
    expect(find.text('GTA III'), findsOneWidget);
  });
}
