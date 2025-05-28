import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:abstract_art_sales/data/services/camera_service.dart';
import 'package:abstract_art_sales/domain/entities/art_piece.dart';
import 'package:abstract_art_sales/presentation/providers/art_provider.dart';

class AddArtScreen extends ConsumerStatefulWidget {
  const AddArtScreen({super.key});

  @override
  AddArtScreenState createState() => AddArtScreenState();
}

class AddArtScreenState extends ConsumerState<AddArtScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _title, _description, _imagePath;
  double? _price;
  CameraController? _controller;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (!mounted) return; // 👈 Verificación segura
    if (cameras.isNotEmpty) {
      _controller = CameraController(cameras[0], ResolutionPreset.high);
      await _controller!.initialize();
      if (!mounted) return; // 👈 Verificación después del await
      setState(() => _isCameraInitialized = true);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _captureImage() async {
    if (_controller == null || !_controller!.value.isInitialized) return;
    final cameraService = CameraService();
    final imagePath = await cameraService.captureAndSaveImage(_controller!);
    if (!mounted) return;
    setState(() {
      _imagePath = imagePath;
    });
  }

  void _saveArtPiece() {
    if (_formKey.currentState!.validate() && _imagePath != null) {
      _formKey.currentState!.save();
      final artPiece = ArtPiece(
        id: const Uuid().v4(),
        title: _title!,
        description: _description!,
        price: _price!,
        imagePath: _imagePath!,
      );

      ref.read(addArtUseCaseProvider).execute(artPiece).then((_) {
        ref.invalidate(artPiecesProvider);
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Art piece added!')),
        );
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Art Piece')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (_isCameraInitialized)
                AspectRatio(
                  aspectRatio: _controller!.value.aspectRatio,
                  child: CameraPreview(_controller!),
                )
              else
                const CircularProgressIndicator(),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _captureImage,
                child: const Text('Capture Image'),
              ),
              if (_imagePath != null) ...[
                const SizedBox(height: 16),
                Image.file(File(_imagePath!), height: 100),
              ],
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) =>
                    value!.isEmpty ? 'Title is required' : null,
                onSaved: (value) => _title = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) =>
                    value!.isEmpty ? 'Description is required' : null,
                onSaved: (value) => _description = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty || double.tryParse(value) == null
                        ? 'Valid price is required'
                        : null,
                onSaved: (value) => _price = double.parse(value!),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveArtPiece,
                child: const Text('Save Art Piece'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
