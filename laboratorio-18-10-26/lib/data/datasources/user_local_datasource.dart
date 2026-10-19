import '../models/user_model.dart';

/// Fuente de datos local que simula una API (con retardo de red).
/// Si luego se quiere consumir una API real, solo se crea otra
/// fuente de datos y el resto de la app no cambia.
class UserLocalDataSource {
  static const List<Map<String, dynamic>> _fakeJson = [
    {
      'id': 1,
      'name': 'Ana Martínez',
      'username': 'anamtz',
      'email': 'ana.martinez@correo.com',
      'phone': '7012-3456',
      'address': {'city': 'San Salvador'},
    },
    {
      'id': 2,
      'name': 'Carlos Rivera',
      'username': 'crivera',
      'email': 'carlos.rivera@correo.com',
      'phone': '7123-4567',
      'address': {'city': 'Santa Tecla'},
    },
    {
      'id': 3,
      'name': 'Lucía Hernández',
      'username': 'luciah',
      'email': 'lucia.hernandez@correo.com',
      'phone': '7234-5678',
      'address': {'city': 'Soyapango'},
    },
    {
      'id': 4,
      'name': 'José Romero',
      'username': 'jromero',
      'email': 'jose.romero@correo.com',
      'phone': '7345-6789',
      'address': {'city': 'Ilopango'},
    },
    {
      'id': 5,
      'name': 'María López',
      'username': 'mlopez',
      'email': 'maria.lopez@correo.com',
      'phone': '7456-7890',
      'address': {'city': 'Santa Ana'},
    },
    {
      'id': 6,
      'name': 'Diego Flores',
      'username': 'dflores',
      'email': 'diego.flores@correo.com',
      'phone': '7567-8901',
      'address': {'city': 'San Miguel'},
    },
  ];

  Future<List<UserModel>> fetchUsers() async {
    await Future.delayed(const Duration(seconds: 1));
    return _fakeJson.map(UserModel.fromJson).toList();
  }
}
