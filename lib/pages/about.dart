import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'About',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          title: const Text('Versiones'),
                          content: const Text('Flutter SDK: 3.13.0\nDart SDK: 3.1.0',),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                                child: const Text('OK'),
                            ),
                          ],
                        );
                    },
                  );
              },
              child: const Text('Mostrar versión'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Regresar a Lista
              },
              child: const Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}
