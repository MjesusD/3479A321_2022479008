import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:aplicacion_3479a321lab3/pages/list_content.dart';
import 'package:aplicacion_3479a321lab3/pages/about.dart';


class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final logger = Logger();

  //CONTADOR 
  int _counter = 0;

  void _increment() {
    setState(() => _counter++);
  }

  void _decrement() {
    setState(() => _counter--);
  }

  void _reset() {
    setState(() => _counter = 0);
  }
  

  @override
  Widget build(BuildContext context) {
    logger.i('Este es el widget MyHomePage');
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Home Page',
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
                Row(
                  children: [
                    const SizedBox(width: 12),
                    Text(
                      'Flutter is an open source framework for building beautiful, natively compiled,\nmulti-platform applications from a single codebase.',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // TEXTO DEL CONTADOR 
                Text(
                  'Contador: $_counter',
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
                
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                 
                     ElevatedButton(onPressed: _decrement, child: Text('-')),
                     ElevatedButton(onPressed: _increment, child: Text('+')),
                     ElevatedButton(onPressed: _reset, child: Text('Reset')),
               
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ListContent()),
                        );
                      },
                      child: const Text('Ir a: "Lista de Contenidos"'),
                    ),
                    

                    // BOTÓN CON LÓGICA DE NAVEGACIÓN SEGÚN CONTADOR 
                    
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
      floatingActionButton: null,
    );
  }
}
