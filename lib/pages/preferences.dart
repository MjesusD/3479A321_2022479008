import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:aplicacion_3479a321lab3/Provider/app_data.dart';

class PreferencesPage extends StatefulWidget {
  const PreferencesPage({super.key});

  @override
  State<PreferencesPage> createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  bool _canReset = true;

//Método cargar preferencias
  Future<void> _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool('canReset') ?? true;

    if (!mounted) return;

    setState(() {
      _canReset = value;
    });

    final appData = Provider.of<AppData>(context, listen: false);
    appData.setCanReset(value);
  }

  //Método cargar preferencias
  Future<void> _savePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('canReset', _canReset);
  }

  //Método de carga de preferencias en la sobreescritura del método initState.

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  //Método de almacenar las preferencias en la sobrescritura del método dispose.
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appData = Provider.of<AppData>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Preferencias'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SwitchListTile(
          title: const Text('Permitir resetear contador'),
          subtitle: const Text('Activa o desactiva el botón Reset'),
          value: _canReset,
          onChanged: (value) {
            setState(() {
              _canReset = value;
            });
            appData.setCanReset(value);
            _savePreferences();
          },
        ),
      ),
    );
  }
}
