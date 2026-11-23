import 'dart:ui' show Size;

import 'package:control_luna/control_luna.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gta_selector_card/gta_selector_card.dart';
import 'package:protagonistas_gta/protagonistas_gta.dart';

import '../lib/main.dart';

void main() {
  testWidgets('integra los tres componentes en la pantalla inicial',
      (tester) async {
    tester.view.physicalSize = const Size(480, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const GtaFanCompanionApp());

    expect(find.byType(ControlLuna), findsOneWidget);
    expect(find.byType(SelectorProtagonistas), findsOneWidget);
    expect(find.byType(GtaSelectorCard), findsOneWidget);
    expect(find.text('MOVER LUNA'), findsOneWidget);
    expect(find.text('Lucía'), findsOneWidget);
    expect(find.text('Jason'), findsOneWidget);
    expect(find.text('¿QUÉ GTA TE GUSTÓ MÁS?'), findsOneWidget);

    await tester.tap(find.text('Jason'));
    await tester.pumpAndSettle();
    expect(find.text('ACTIVO'), findsOneWidget);

    await tester.tap(find.text('III'));
    await tester.pumpAndSettle();
    expect(find.text('GTA III'), findsOneWidget);
  });
}
