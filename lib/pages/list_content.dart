import 'package:flutter/material.dart';
import 'package:aplicacion_3479a321lab3/pages/about.dart';

class ListContent extends StatelessWidget {
  const ListContent({super.key});

  @override
  Widget build(BuildContext context) {
    
    final List<String> herramientas = [
      'Hot Reload',
      'Flutter DevTools',
      'Widget Tree',
      'Material Widgets',
      'DartPad',
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Lista de Contenidos',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),

      // ListView.builder para mostrar la lista
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: herramientas.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.check_circle_outline),
              title: Text(herramientas[index]),
            ),
          );
        },
      ),

      // Botones fijos en la parte inferior
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Volver'),
            ),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Explora más en flutter.dev')),
                );
              },
              child: const Text('Mostrar mensaje'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const About()),
                );
              },
              child: const Text('About'),
            ),
          ],
        ),
      ),
    );
  }
}
