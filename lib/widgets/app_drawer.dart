import 'package:aplicacion_3479a321lab3/pages/home_page.dart';
import 'package:aplicacion_3479a321lab3/pages/preferences.dart';
import 'package:flutter/material.dart';
import 'package:aplicacion_3479a321lab3/Provider/app_data.dart';
import 'package:aplicacion_3479a321lab3/pages/list_content.dart';
import 'package:aplicacion_3479a321lab3/pages/gallery_screen.dart';
import 'package:aplicacion_3479a321lab3/pages/about.dart';

class AppDrawer extends StatelessWidget {
  final AppData appData;
  final VoidCallback? onPreferencesChanged; 

  const AppDrawer({
    super.key,
    required this.appData,
    this.onPreferencesChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Menú',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Bienvenido, ${appData.userName}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          _drawerItem(context, Icons.home, 'Inicio', () {
            Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => MyHomePage(title: 'Inicio')),
              (route) => false,
            );
          }),
          _drawerItem(context, Icons.list, 'Lista de Contenidos', () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (_) => const ListContent()));
          }),
          _drawerItem(context, Icons.info, 'Acerca de', () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (_) => const About()));
          }),
          _drawerItem(context, Icons.photo_library, 'Galería', () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const GalleryScreen()),
            );
          }),

          _drawerItem(context, Icons.settings, 'Preferencias', () async {
            Navigator.pop(context);
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PreferencesPage()),
            );
            

            // Callback después de volver de preferencias
            if (onPreferencesChanged != null) {
              onPreferencesChanged!();
            }
          }),
        ],
      ),
    );
  }

  Widget _drawerItem(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
