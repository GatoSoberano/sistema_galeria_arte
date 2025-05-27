import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:open_file/open_file.dart';

class DownloadService {
  Future<bool> downloadImage(String assetPath, BuildContext context) async {
    try {
      // Para Android 13+, usar el directorio temporal para evitar problemas de permisos
      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        if (androidInfo.version.sdkInt >= 33) {
          // No se requiere permiso explícito para getTemporaryDirectory
          print('Usando directorio temporal en Android 13+ (API ${androidInfo.version.sdkInt})');
        } else {
          // Para versiones anteriores, solicitar permiso de almacenamiento (opcional, pero mantendremos la lógica)
          final storageStatus = await Permission.storage.request();
          if (!storageStatus.isGranted) {
            print('Permiso de almacenamiento denegado: $storageStatus');
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Permiso de almacenamiento denegado. Por favor, otorga el permiso en ajustes.'),
                  action: SnackBarAction(
                    label: 'Abrir ajustes',
                    onPressed: () => openAppSettings(),
                  ),
                ),
              );
            }
            return false;
          }
          print('Permiso otorgado: $storageStatus');
        }
      }

      // Cargar la imagen desde los activos
      final byteData = await DefaultAssetBundle.of(context).load(assetPath);
      final bytes = byteData.buffer.asUint8List();
      print('Imagen cargada desde: $assetPath, Tamaño: ${bytes.length} bytes');

      // Usar el directorio temporal de la app
      final directory = await getTemporaryDirectory();
      print('Directorio de guardado: ${directory.path}');

      // Crear un archivo con un nombre único
      final fileName = assetPath.split('/').last;
      final filePath = '${directory.path}/$fileName';
      final file = File(filePath);

      // Escribir los bytes en el archivo
      await file.writeAsBytes(bytes);
      print('Imagen guardada en: $filePath');

      // Abrir el archivo después de descargarlo
      final result = await OpenFile.open(filePath);
      print('Resultado de abrir el archivo: $result');
      return true;
    } catch (e) {
      print('Error al descargar la imagen: $e');
      return false;
    }
  }
}