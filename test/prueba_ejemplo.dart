import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Prueba de ejemplo: verificar suma básica', () {
    expect(4 + 4, equals(8));
  });

  test('Prueba de ejemplo: verificar concatenación de cadenas', () {
    const String primero = 'Moisés';
    const String segundo = 'Navajas';
    expect('$primero $segundo', equals('Moisés Navajas'));
  });
}

