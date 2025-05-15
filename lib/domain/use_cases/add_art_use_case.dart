import 'package:abstract_art_sales/domain/entities/art_piece.dart';
import 'package:abstract_art_sales/domain/repositories/art_repository.dart';

class AddArtUseCase {
  final ArtRepository repository;

  AddArtUseCase(this.repository);

  Future<void> execute(ArtPiece artPiece) async {
    await repository.addArtPiece(artPiece);
  }
}