import 'package:flutter/material.dart';
import 'package:aplicacion_3479a321lab3/entity/activity.dart';
import 'package:aplicacion_3479a321lab3/services/database_helper.dart';

class ActivityListPage extends StatefulWidget {
  const ActivityListPage({super.key});

  @override
  State<ActivityListPage> createState() => _ActivityListPageState();
}

class _ActivityListPageState extends State<ActivityListPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Activity> _activities = [];

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  // Función que consulta la base de datos usando DatabaseHelper
  Future<void> _loadActivities() async {
    final activities = await _dbHelper.getActivities();
    setState(() {
      _activities = activities;
    });
  }

  // Función para añadir una actividad usando DatabaseHelper
  Future<void> _addActivity() async {
    final now = DateTime.now();
    final newActivity = Activity(id: 0, fecha: now, nombre: 'Actividad ${_activities.length + 1}');
    await _dbHelper.insertActivity(newActivity);
    _loadActivities();
  }

  // Función para editar una actividad usando DatabaseHelper
  Future<void> _editActivity(Activity activity) async {
    final nuevoNombre = await showDialog<String>(
      context: context,
      builder: (context) {
        final controller = TextEditingController(text: activity.nombre);
        return AlertDialog(
          title: const Text('Editar actividad'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(labelText: 'Nombre'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, controller.text),
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );

    if (nuevoNombre != null && nuevoNombre.isNotEmpty) {
      final updatedActivity = Activity(id: activity.id, fecha: activity.fecha, nombre: nuevoNombre);
      await _dbHelper.updateActivity(updatedActivity);
      _loadActivities();
    }
  }

  // Función para eliminar una actividad usando DatabaseHelper
  Future<void> _deleteActivity(int id) async {
    await _dbHelper.deleteActivity(id);
    _loadActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Actividades'),
      ),
      body: ListView.builder(
        itemCount: _activities.length,
        itemBuilder: (context, index) {
          final activity = _activities[index];
          return ListTile(
            title: Text(activity.nombre),
            subtitle: Text(activity.fecha.toLocal().toString().split('.')[0]),
            onTap: () => _editActivity(activity),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _deleteActivity(activity.id),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addActivity,
        child: const Icon(Icons.add),
      ),
    );
  }
}
