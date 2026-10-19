import '../../domain/entities/user.dart';

/// Modelo de datos: sabe convertirse desde/hacia JSON.
/// Extiende la entidad para poder entregarse a la capa de dominio.
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.name,
    required super.username,
    required super.email,
    required super.phone,
    required super.city,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int,
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      city: (json['address'] as Map<String, dynamic>)['city'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'username': username,
        'email': email,
        'phone': phone,
        'address': {'city': city},
      };
}
