import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:aplicacion_3479a321lab3/pages/list_content.dart';
import 'package:aplicacion_3479a321lab3/pages/about.dart';

final logger = Logger();

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Constructor
  _MyHomePageState() {
    logger.i("_MyHomePageState - mounted: $mounted");
  }

  // CONTADOR
  int _counter = 0;

  void _increment() {
    setState(() {
      logger.i("Incrementando contador");
      _counter++;
    });
  }

  void _decrement() {
    setState(() {
      logger.i("Decrementando contador");
      _counter--;
    });
  }

  void _reset() {
    setState(() {
      logger.i("Reiniciando contador");
      _counter = 0;
    });
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
                Text(
                  'Contador: $_counter',
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
                    ElevatedButton(onPressed: _decrement, child: const Text('-')),
                    ElevatedButton(onPressed: _increment, child: const Text('+')),
                    ElevatedButton(onPressed: _reset, child: const Text('Reset')),
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
                        if (_counter % 2 == 0) {
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
