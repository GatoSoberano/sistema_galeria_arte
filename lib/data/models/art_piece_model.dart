import 'package:hive/hive.dart';
part 'art_piece_model.g.dart';

@HiveType(typeId: 0)
class ArtPieceModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final double price;

  @HiveField(4)
  final String imagePath;

  ArtPieceModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imagePath,
  });
}