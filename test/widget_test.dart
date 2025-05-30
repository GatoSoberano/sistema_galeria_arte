import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MiWidget extends StatelessWidget {
  const MiWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hola mundo'),
        ),
      ),
    );
  }
}

void main() {
  testWidgets('Texto aparece correctamente', (WidgetTester tester) async {
    await tester.pumpWidget(const MiWidget());
    expect(find.text('Hola mundo'), findsOneWidget);
  });
}
