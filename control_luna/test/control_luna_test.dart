import 'package:control_luna/control_luna.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('mover el slider actualiza la fase y avisa a la pantalla',
      (tester) async {
    var fase = 5;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) => Center(
              child: SizedBox(
                width: 340,
                child: ControlLuna(
                  valor: fase,
                  onChanged: (nuevo) => setState(() => fase = nuevo),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text('5/6'), findsOneWidget);
    await tester.drag(find.byType(Slider), const Offset(500, 0));
    await tester.pumpAndSettle();

    expect(fase, 6);
    expect(find.text('6/6'), findsOneWidget);
    expect(find.text('Fase 6/6'), findsOneWidget);
  });
}
