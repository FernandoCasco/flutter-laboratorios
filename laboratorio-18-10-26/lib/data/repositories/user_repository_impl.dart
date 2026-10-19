import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_local_datasource.dart';

/// Implementación concreta del repositorio (capa de datos).
class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource dataSource;

  UserRepositoryImpl(this.dataSource);

  @override
  Future<List<User>> getUsers() async {
    return await dataSource.fetchUsers();
  }
}
