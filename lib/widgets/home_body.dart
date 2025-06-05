import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aplicacion_3479a321lab3/Provider/app_data.dart';
import 'package:aplicacion_3479a321lab3/widgets/action_buttons.dart';
import 'package:aplicacion_3479a321lab3/pages/activity_list.dart';
import 'package:logger/logger.dart';


class HomeBody extends StatefulWidget {
  final AppData appData;
  const HomeBody({super.key, required this.appData});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {

  final Logger _logger = Logger();

  String imageUrl = 'https://picsum.photos/250?image=20';


  Future<void> _getNewImage() async {
  final int imageIndex = widget.appData.counter % 100;
  final newImageUrl = 'https://picsum.photos/250?random=$imageIndex'; 

  try {
    final response = await http.get(Uri.parse(newImageUrl));
    if (response.statusCode == 200) {
      _logger.i('Imagen encontrada: $newImageUrl');
      setState(() {
        imageUrl = newImageUrl;
      });
    } else {
      _logger.w('Imagen no encontrada. Status: ${response.statusCode}');
      setState(() {
        imageUrl = '';
      });
    }
  } catch (e) {
    _logger.e('Error al obtener la imagen: $e');
    setState(() {
      imageUrl = '';
    });
  }
}


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Align(
        alignment: Alignment.topCenter,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: theme.colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Flutter es un framework para crear apps nativas multiplataforma con un solo código base.',
                  style: theme.textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  'Bienvenido, ${widget.appData.userName}',
                  style: theme.textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Contador: ${widget.appData.counter}',
                  style: theme.textTheme.displaySmall!.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                const SizedBox(height: 20),

                // Imagen con errorBuilder
                Image.network(
                  imageUrl.isNotEmpty ? imageUrl : '',
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Text(
                      'Failed to load image',
                      style: TextStyle(color: Colors.red),
                    );
                  },
                ),
                const SizedBox(height: 10),

                // Botón para obtener imagen
                ElevatedButton.icon(
                  onPressed: _getNewImage,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Obtener nueva imagen'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.secondary,
                    foregroundColor: theme.colorScheme.onSecondary,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    textStyle: theme.textTheme.titleMedium,
                  ),
                ),

                const SizedBox(height: 20),
                ActionButtons(appData: widget.appData),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ActivityListPage()),
                    );
                  },
                  icon: const Icon(Icons.list),
                  label: const Text('Ver Actividades'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.secondary,
                    foregroundColor: theme.colorScheme.onSecondary,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    textStyle: theme.textTheme.titleMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
