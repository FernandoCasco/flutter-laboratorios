import 'package:flutter/foundation.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/get_users.dart';

/// Estado reactivo de la lista de usuarios.
class UserProvider extends ChangeNotifier {
  final GetUsers getUsers;

  UserProvider(this.getUsers);

  List<User> _users = [];
  bool _isLoading = false;
  String? _error;

  List<User> get users => _users;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadUsers() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _users = await getUsers();
    } catch (e) {
      _error = 'No se pudieron cargar los usuarios: $e';
    }

    _isLoading = false;
    notifyListeners();
  }
}
