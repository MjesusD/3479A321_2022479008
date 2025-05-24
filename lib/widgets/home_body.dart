import 'package:flutter/material.dart';
import 'package:aplicacion_3479a321lab3/Provider/app_data.dart';
import 'package:aplicacion_3479a321lab3/widgets/action_buttons.dart';
import 'package:aplicacion_3479a321lab3/pages/activity_list.dart';


class HomeBody extends StatelessWidget {
  final AppData appData;
  const HomeBody({super.key, required this.appData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: theme.colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Flutter es un framework para crear apps nativas multiplataforma con un solo código base.',
                style: theme.textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Text(
                'Bienvenido, ${appData.userName}',
                style: theme.textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Contador: ${appData.counter}',
                style: theme.textTheme.displaySmall!.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
              ),
              const SizedBox(height: 20),
              ActionButtons(appData: appData),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ActivityListPage()),
                  );
                },
                icon: const Icon(Icons.list),
                label: const Text('Ver Actividades'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.secondary,
                  foregroundColor: theme.colorScheme.onSecondary,
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  textStyle: theme.textTheme.titleMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
