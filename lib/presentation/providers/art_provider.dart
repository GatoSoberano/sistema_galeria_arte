import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:abstract_art_sales/data/repositories/art_repository_impl.dart';
import 'package:abstract_art_sales/domain/entities/art_piece.dart';
import 'package:abstract_art_sales/domain/use_cases/add_art_use_case.dart';

final artRepositoryProvider = Provider((ref) => ArtRepositoryImpl());

final addArtUseCaseProvider =
    Provider((ref) => AddArtUseCase(ref.read(artRepositoryProvider)));

final artPiecesProvider = FutureProvider<List<ArtPiece>>((ref) async {
  final repository = ref.read(artRepositoryProvider);
  return repository.getAllArtPieces();
});