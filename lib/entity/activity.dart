class Activity {
  int id;
  DateTime fecha;
  String nombre;

  Activity({
    required this.id,
    required this.fecha,
    required this.nombre,
  });

  // Convierte un objeto Actividad a Map para almacenar 
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fecha': fecha.toIso8601String(), 
      'nombre': nombre,
    };
  }

  // Crea un objeto Actividad desde un Map 
  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      id: map['id'],
      fecha: DateTime.parse(map['fecha']),
      nombre: map['nombre'],
    );
  }
}
