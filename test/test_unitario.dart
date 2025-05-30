import 'package:flutter_test/flutter_test.dart';

int multiplicar(int a, int b) => a * b;

void main() {
  group('Tests de multiplicar()', () {
    test('2 * 3 = 6', () {
      expect(multiplicar(2, 3), equals(6));
    });

    test('0 * 100 = 0', () {
      expect(multiplicar(0, 100), equals(0));
    });

    test('-1 * 5 = -5', () {
      expect(multiplicar(-1, 5), equals(-5));
    });
  });
}
