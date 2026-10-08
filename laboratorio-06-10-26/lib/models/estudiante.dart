/// Modelo de datos que representa al estudiante.
class Estudiante {
  final String nombre;
  final String carnet;
  final int edad;
  final bool activo;

  Estudiante({
    required this.nombre,
    required this.carnet,
    required this.edad,
    required this.activo,
  });

  /// Convierte el objeto a un Map para poder codificarlo como JSON.
  Map<String, dynamic> toJson() => {
        'nombre': nombre,
        'carnet': carnet,
        'edad': edad,
        'activo': activo,
      };

  /// Crea un Estudiante a partir de un Map obtenido al decodificar JSON.
  factory Estudiante.fromJson(Map<String, dynamic> json) => Estudiante(
        nombre: json['nombre'] as String,
        carnet: json['carnet'] as String,
        edad: json['edad'] as int,
        activo: json['activo'] as bool,
      );
}