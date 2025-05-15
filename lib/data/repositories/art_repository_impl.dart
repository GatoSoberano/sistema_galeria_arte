import 'package:hive/hive.dart';
import 'package:abstract_art_sales/core/constants.dart';
import 'package:abstract_art_sales/data/models/art_piece_model.dart';
import 'package:abstract_art_sales/domain/entities/art_piece.dart';
import 'package:abstract_art_sales/domain/repositories/art_repository.dart';

class ArtRepositoryImpl implements ArtRepository {
  final Box<ArtPieceModel> _artBox = Hive.box<ArtPieceModel>(Constants.artBox);

  @override
  Future<void> addArtPiece(ArtPiece artPiece) async {
    final model = ArtPieceModel(
      id: artPiece.id,
      title: artPiece.title,
      description: artPiece.description,
      price: artPiece.price,
      imagePath: artPiece.imagePath,
    );
    await _artBox.put(artPiece.id, model);
  }

  @override
  Future<List<ArtPiece>> getAllArtPieces() async {
    return _artBox.values
        .map((model) => ArtPiece(
              id: model.id,
              title: model.title,
              description: model.description,
              price: model.price,
              imagePath: model.imagePath,
            ))
        .toList();
  }
}