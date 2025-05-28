import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:open_file/open_file.dart';

class DownloadService {
  Future<bool> downloadImage(String assetPath, BuildContext context) async {
    try {
      bool permissionGranted = true;

      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt < 33) {
          final storageStatus = await Permission.storage.request();
          permissionGranted = storageStatus.isGranted;
        }
      }

      if (!permissionGranted) {
        // Mover esta lógica fuera del async gap
        _showPermissionDeniedSnackbar(context);
        return false;
      }

      final byteData = await DefaultAssetBundle.of(context).load(assetPath);
      final bytes = byteData.buffer.asUint8List();

      final directory = await getTemporaryDirectory();
      final fileName = assetPath.split('/').last;
      final filePath = '${directory.path}/$fileName';
      final file = File(filePath);

      await file.writeAsBytes(bytes);
      await OpenFile.open(filePath);

      return true;
    } catch (e) {
      debugPrint('Error al descargar la imagen: $e');
      return false;
    }
  }

  void _showPermissionDeniedSnackbar(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
      if (scaffoldMessenger != null) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: const Text('Permiso de almacenamiento denegado.'),
            action: SnackBarAction(
              label: 'Abrir ajustes',
              onPressed: () => openAppSettings(),
            ),
          ),
        );
      }
    });
  }
}
