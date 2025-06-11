import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:logger/logger.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

final logger = Logger();

class PictureScreen extends StatefulWidget {
  final CameraDescription camera;

  const PictureScreen({super.key, required this.camera});

  @override
  State<PictureScreen> createState() => _PictureScreenState();
}

class _PictureScreenState extends State<PictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Picture Screen')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();

            if (!mounted) return;

            // Obtener directorio para guardar fotos
            final Directory appDir = await getApplicationDocumentsDirectory();
            final Directory imagesDir = Directory('${appDir.path}/MyAppPhotos');

            // Crear carpeta si no existe
            if (!await imagesDir.exists()) {
              await imagesDir.create(recursive: true);
            }

            // Nombre nuevo para la imagen 
            final String fileName = 'IMG_${DateTime.now().millisecondsSinceEpoch}.jpg';

            // Nueva ruta donde guardar la imagen
            final String newPath = path.join(imagesDir.path, fileName);

            // Copiar archivo temporal a la carpeta fija
            final File newImage = await File(image.path).copy(newPath);

            // Navegar a la vista previa pasando la nueva ruta
            final result = await Navigator.of(context).push<String>(
              MaterialPageRoute(
                builder: (context) => PreviewPictureScreen(imagePath: newImage.path),
              ),
            );

            if (!mounted) return;

            if (result != null) {
              Navigator.of(context).pop(result);
            }
          } catch (e, stackTrace) {
            logger.e('Error al tomar la foto', error: e, stackTrace: stackTrace);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

// Vista previa de la foto capturada
class PreviewPictureScreen extends StatelessWidget {
  final String imagePath;

  const PreviewPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vista previa')),
      body: Column(
        children: [
          Expanded(
            child: Image.file(File(imagePath)),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.check),
                label: const Text('Usar esta foto'),
                onPressed: () {
                  Navigator.of(context).pop(imagePath); // Retorna la ruta al Home
                },
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.cancel),
                label: const Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop(); 
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
