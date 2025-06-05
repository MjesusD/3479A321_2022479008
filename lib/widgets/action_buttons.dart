import 'package:flutter/material.dart';
import 'package:aplicacion_3479a321lab3/Provider/app_data.dart';
import 'package:aplicacion_3479a321lab3/pages/list_content.dart';
import 'package:aplicacion_3479a321lab3/pages/about.dart';

class ActionButtons extends StatelessWidget {
  final AppData appData;
  const ActionButtons({super.key, required this.appData});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        ElevatedButton(
          onPressed: appData.canReset ? appData.decrement : null,
          child: const Text('-'),
        ),
        ElevatedButton(
          onPressed: appData.increment,
          child: const Text('+'),
        ),
        ElevatedButton(
          onPressed: appData.canReset ? appData.reset : null,
          child: const Text('Reset'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const ListContent()));
          },
          child: const Text('Ir a Lista'),
        ),
        ElevatedButton(
          onPressed: () {
            final destino = appData.counter % 2 == 0 ? const ListContent() : const About();
            Navigator.push(context, MaterialPageRoute(builder: (_) => destino));
          },
          child: const Text('Ir según contador'),
        ),
        
      ],
    );
  }
}
