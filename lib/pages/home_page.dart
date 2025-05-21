import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

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
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              logger.i("onPressed, ejecutando setState");
            });
          },
          child: const Text("Presiona para setState"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          logger.i("FloatingActionButton presionado");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
