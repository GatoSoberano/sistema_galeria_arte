import 'package:abstract_art_sales/domain/entities/art_piece.dart';

abstract class ArtRepository {
  Future<void> addArtPiece(ArtPiece artPiece);
  Future<List<ArtPiece>> getAllArtPieces();
}