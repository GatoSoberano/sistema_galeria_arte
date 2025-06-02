import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Prueba de ejemplo: verificar suma básica', () {
    expect(1 + 1, equals(2));
  });

  test('Prueba de ejemplo: verificar concatenación de cadenas', () {
    const String primero = 'Hola';
    const String segundo = 'Mundo';
    expect('$primero $segundo', equals('Hola Mundo'));
  });
}