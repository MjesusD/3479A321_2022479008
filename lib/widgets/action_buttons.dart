import 'package:flutter/material.dart';
import 'package:aplicacion_3479a321lab3/Provider/app_data.dart';

class ActionButtons extends StatelessWidget {
  final AppData appData;
  final VoidCallback onTakePhoto;

  const ActionButtons({
    super.key,
    required this.appData,
    required this.onTakePhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
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
          onPressed: onTakePhoto,
          child: const Text('Tomar Foto'),
        ),
      ],
    );
  }
}
