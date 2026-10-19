import '../entities/user.dart';

/// Contrato del repositorio (capa de dominio).
/// La UI y los casos de uso dependen de esta abstracción,
/// nunca de la implementación concreta.
abstract class UserRepository {
  Future<List<User>> getUsers();
}
