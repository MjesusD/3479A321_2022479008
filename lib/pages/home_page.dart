import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aplicacion_3479a321lab3/Provider/app_data.dart';
import 'package:aplicacion_3479a321lab3/widgets/app_drawer.dart';
import 'package:aplicacion_3479a321lab3/widgets/home_body.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late AppData appData;

  @override
  void initState() {
    super.initState();
    appData = Provider.of<AppData>(context, listen: false);
    _loadPreferencias();
  }

  Future<void> _loadPreferencias() async {
    await appData.loadPreferencias(); // carga de preferencias al iniciar
  }

  @override
  Widget build(BuildContext context) {
    appData = Provider.of<AppData>(context); // actualización reactiva

    return Scaffold(
      
      appBar: AppBar(
        
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSecondary,
              ),
        ),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        actions: [
          if (appData.canReset)
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                appData.reset(); // solo si canReset es true
              },
            ),
        ],
      ),
      drawer: AppDrawer(
        appData: appData,
        onPreferencesChanged: _loadPreferencias, 
      ),
      body: HomeBody(appData: appData),
    );
  }
}
