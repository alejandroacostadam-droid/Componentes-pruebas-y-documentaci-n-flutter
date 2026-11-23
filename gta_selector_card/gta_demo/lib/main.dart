import 'package:flutter/material.dart';
import 'package:gta_selector_card/gta_selector_card.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF070B18),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GtaSelectorCard(onChanged: (i) => debugPrint('Elegido: $i')),
          ),
        ),
      ),
    );
  }
}
