/// Entidad de dominio: representa un usuario sin depender de ninguna
/// librería externa ni del formato en que llegan los datos.
class User {
  final int id;
  final String name;
  final String username;
  final String email;
  final String phone;
  final String city;

  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.phone,
    required this.city,
  });
}
