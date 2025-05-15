import 'dart:io';
import 'package:flutter/material.dart';
import 'package:abstract_art_sales/data/services/download_service.dart';
import 'package:abstract_art_sales/domain/entities/art_piece.dart';

class ArtCard extends StatelessWidget {
  final ArtPiece artPiece;
  final bool isCartView;

  const ArtCard({super.key, required this.artPiece, this.isCartView = false});

  Future<void> _downloadImage(BuildContext context) async {
    final downloadService = DownloadService();
    final success = await downloadService.downloadImage(artPiece.imagePath, context);
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success
              ? '${artPiece.title} downloaded to Downloads folder'
              : 'Failed to download image',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: artPiece.imagePath.startsWith('assets/')
                ? Image.asset(
                    artPiece.imagePath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  )
                : Image.file(
                    File(artPiece.imagePath),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  artPiece.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  artPiece.description,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '\$${artPiece.price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                if (!isCartView)
                  ElevatedButton(
                    onPressed: () => _downloadImage(context),
                    child: const Text('Download Image'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}