import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart'; 
import 'package:aplicacion_3479a321lab3/pages/list_content.dart';
import 'package:aplicacion_3479a321lab3/pages/about.dart';
import 'package:aplicacion_3479a321lab3/Provider/app_data.dart'; 

final logger = Logger();

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  _MyHomePageState() {
    logger.i("_MyHomePageState - mounted: $mounted");
  }

  @override
  void initState() {
    super.initState();
    logger.i("initState - mounted: $mounted");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logger.i("didChangeDependencies - mounted: $mounted");
  }

  @override
  void didUpdateWidget(covariant MyHomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    logger.i("didUpdateWidget - mounted: $mounted");
  }

  @override
  void setState(VoidCallback fn) {
    logger.i("setState - mounted: $mounted");
    super.setState(fn);
  }

  @override
  void reassemble() {
    super.reassemble();
    logger.i("reassemble - mounted: $mounted");
  }

  @override
  void deactivate() {
    super.deactivate();
    logger.i("deactivate - mounted: $mounted");
  }

  @override
  void dispose() {
    super.dispose();
    logger.i("dispose - mounted: $mounted");
  }

  @override
  Widget build(BuildContext context) {
    logger.i("build - mounted: $mounted");

    final appData = Provider.of<AppData>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          color: Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Flutter es un framework de código abierto para crear aplicaciones bellas, compiladas nativamente y multiplataforma con un solo código base.',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // Mostrar el nombre del usuario
                Text(
                  'Bienvenid@, ${appData.userName}',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                const SizedBox(height: 10),

                Text(
                  'Contador: ${appData.counter}',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                const SizedBox(height: 20),

                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    // Botón restar deshabilitado si es !canReset
                    ElevatedButton(
                      onPressed: appData.canReset
                          ? () => context.read<AppData>().decrement()
                          : null,
                      child: const Text('-'),
                    ),
                    ElevatedButton(
                      onPressed: () => context.read<AppData>().increment(),
                      child: const Text('+'),
                    ),
                    // Botón reset deshabilitado si es !canReset
                    ElevatedButton(
                      onPressed: appData.canReset
                          ? () => context.read<AppData>().reset()
                          : null,
                      child: const Text('Reset'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ListContent()),
                        );
                      },
                      child: const Text('Ir a: "Lista de Contenidos"'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (appData.counter % 2 == 0) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const ListContent()),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const About()),
                          );
                        }
                      },
                      child: const Text('Ir según el contador'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
