import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:logger/logger.dart';

final logger = Logger();

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<File> images = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    setState(() {
      loading = true;
    });

    try {
      final Directory appDir = await getApplicationDocumentsDirectory();
      final Directory imagesDir = Directory('${appDir.path}/MyAppPhotos');

      if (await imagesDir.exists()) {
        final List<FileSystemEntity> files = imagesDir.listSync();

        final imgs = files.whereType<File>().where((file) {
          final ext = path.extension(file.path).toLowerCase();
          return ext == '.jpg' || ext == '.jpeg' || ext == '.png';
        }).toList();

        setState(() {
          images = imgs;
        });
      }
    } catch (e) {
      logger.e('Error cargando imágenes: $e');
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  void _openImagePreview(File imageFile) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ImagePreviewScreen(imageFile: imageFile),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Scaffold(
        appBar: AppBar(title: Text('Galería')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Galería')),
      body: images.isEmpty
          ? const Center(child: Text('No hay imágenes guardadas'))
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: images.length,
              itemBuilder: (context, index) {
                final file = images[index];
                return GestureDetector(
                  onTap: () => _openImagePreview(file),
                  child: Image.file(
                    file,
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
    );
  }
}

class ImagePreviewScreen extends StatelessWidget {
  final File imageFile;

  const ImagePreviewScreen({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vista previa')),
      body: Center(
        child: Image.file(imageFile),
      ),
    );
  }
}
