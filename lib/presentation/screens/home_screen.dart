import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:abstract_art_sales/presentation/providers/art_provider.dart';
import 'package:abstract_art_sales/presentation/screens/add_art_screen.dart';
import 'package:abstract_art_sales/presentation/screens/cart_screen.dart';
import 'package:abstract_art_sales/presentation/widgets/art_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final artPiecesAsync = ref.watch(artPiecesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('APP DE OBRAS DE ARTE'),
        centerTitle: true,
      ),
      body: artPiecesAsync.when(
        data: (artPieces) => GridView.builder(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.7,
          ),
          itemCount: artPieces.length,
          itemBuilder: (context, index) => ArtCard(artPiece: artPieces[index]),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Error: $error')),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add Art'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddArtScreen()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CartScreen()),
            );
          }
        },
      ),
    );
  }
}