import 'package:flutter/material.dart';
import 'package:aplicacion_3479a321lab3/pages/about.dart';

class ListContent extends StatelessWidget {
  const ListContent({super.key});

  @override
  Widget build(BuildContext context) {
    final herramientas = [
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
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Herramientas de Flutter:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(herramientas[0]),
          Text(herramientas[1]),
          Text(herramientas[2]),
          Text(herramientas[3]),
          Text(herramientas[4]),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('Volver al Home'),
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
                child: const Text('Ir a: "About"'),
              ),
              
            ],
          ),
        ],
      ),
    );
  }
}
