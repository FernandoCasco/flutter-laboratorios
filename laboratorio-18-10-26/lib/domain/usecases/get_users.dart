import '../entities/user.dart';
import '../repositories/user_repository.dart';

/// Caso de uso: obtener la lista de usuarios.
class GetUsers {
  final UserRepository repository;

  GetUsers(this.repository);

  Future<List<User>> call() => repository.getUsers();
}
