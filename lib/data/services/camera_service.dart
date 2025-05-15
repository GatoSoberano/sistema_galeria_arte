import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:abstract_art_sales/core/constants.dart';

class CameraService {
  Future<String?> captureAndSaveImage(CameraController controller) async {
    try {
      final XFile image = await controller.takePicture();
      final Directory directory = await getApplicationDocumentsDirectory();
      final String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      final String filePath = '${directory.path}/$fileName';

      final File compressedImage = await _compressImage(File(image.path));
      await compressedImage.copy(filePath);
      return filePath;
    } catch (e) {
      return null;
    }
  }

  Future<File> _compressImage(File file) async {
    final compressedFile = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      '${file.path}_compressed.jpg',
      quality: (Constants.imageCompressionQuality * 100).toInt(),
      minWidth: Constants.imageMaxWidth,
    );
    return File(compressedFile!.path);
  }
}