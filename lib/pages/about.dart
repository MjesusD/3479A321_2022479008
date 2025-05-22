import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aplicacion_3479a321lab3/Provider/app_data.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    final appData = context.read<AppData>();
    _nameController = TextEditingController(text: appData.userName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appData = context.watch<AppData>();

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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Contador actual: ${appData.counter}',
                  style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 20),

              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre de usuario',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  appData.setUserName(value);
                },
              ),
              const SizedBox(height: 20),

              SwitchListTile(
                title: const Text('Permitir reiniciar contador'),
                value: appData.canReset,
                onChanged: (value) {
                  appData.setCanReset(value);
                },
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Versiones'),
                      content: const Text('Flutter SDK: 3.13.0\nDart SDK: 3.1.0'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Mostrar versión'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Volver'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
