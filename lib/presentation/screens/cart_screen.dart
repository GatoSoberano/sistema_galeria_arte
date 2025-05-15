import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: const Center(
        child: Text(
          'Usa el botón download para caargar las imagenes al carrito de compras.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}