import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:abstract_art_sales/data/models/art_piece_model.dart';
import 'package:abstract_art_sales/presentation/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ArtPieceModelAdapter());
  final box = await Hive.openBox<ArtPieceModel>('artPieces');

  
  await box.clear();


  await box.put(
    'basquiat1',
    ArtPieceModel(
      id: 'basquiat1',
      title: 'Untitled (1982)',
      description: 'Jean-Michel Basquiat, 1982. Neo-expressionist work with vibrant colors and social commentary.',
      price: 1500.00,
      imagePath: 'assets/images/basquiat1.jpg',
    ),
  );
  await box.put(
    'haring1',
    ArtPieceModel(
      id: 'haring1',
      title: 'Radiant Baby',
      description: 'Keith Haring, 1990. Iconic pop art with bold lines and cultural symbolism.',
      price: 1800.00,
      imagePath: 'assets/images/haring1.jpg',
    ),
  );
  await box.put(
    'kusama1',
    ArtPieceModel(
      id: 'kusama1',
      title: 'Infinity Dots',
      description: 'Yayoi Kusama, 2008. Abstract polka dot pattern exploring infinity and obsession.',
      price: 2000.00,
      imagePath: 'assets/images/kusama1.jpg',
    ),
  );
  await box.put(
    'rothko1',
    ArtPieceModel(
      id: 'rothko1',
      title: 'No. 61 (Rust and Blue)',
      description: 'Mark Rothko, 1953. Abstract expressionist work with emotional depth and color fields.',
      price: 1800.00,
      imagePath: 'assets/images/rothko1.jpg',
    ),
  );
  await box.put(
    'pollock1',
    ArtPieceModel(
      id: 'pollock1',
      title: 'Number 1 (Lavender Mist)',
      description: 'Jackson Pollock, 1950. Action painting with intricate drip patterns.',
      price: 2200.00,
      imagePath: 'assets/images/pollock1.jpg',
    ),
  );
  await box.put(
    'kandinsky1',
    ArtPieceModel(
      id: 'kandinsky1',
      title: 'Composition VIII',
      description: 'Wassily Kandinsky, 1923. Abstract work with geometric shapes and vibrant colors.',
      price: 1600.00,
      imagePath: 'assets/images/kandinsky1.jpg',
    ),
  );
  await box.put(
    'mondrian1',
    ArtPieceModel(
      id: 'mondrian1',
      title: 'Composition with Red, Blue, and Yellow',
      description: 'Piet Mondrian, 1930. Neoplasticism with primary colors and grid structure.',
      price: 1400.00,
      imagePath: 'assets/images/mondrian1.jpg',
    ),
  );
  await box.put(
    'malevich1',
    ArtPieceModel(
      id: 'malevich1',
      title: 'Black Square',
      description: 'Kazimir Malevich, 1915. Suprematist work exploring pure abstraction.',
      price: 1700.00,
      imagePath: 'assets/images/malevich1.jpg',
    ),
  );
  await box.put(
    'miro1',
    ArtPieceModel(
      id: 'miro1',
      title: 'The Tilled Field',
      description: 'Joan Miró, 1923. Surrealist work with dreamlike shapes and symbols.',
      price: 1900.00,
      imagePath: 'assets/images/miro1.jpg',
    ),
  );
  await box.put(
    'martin1',
    ArtPieceModel(
      id: 'martin1',
      title: 'With My Back to the World',
      description: 'Agnes Martin, 1997. Minimalist work with subtle grids and soft colors.',
      price: 2100.00,
      imagePath: 'assets/images/martin1.jpg',
    ),
  );

  runApp(const ProviderScope(child: MyApp()));
}