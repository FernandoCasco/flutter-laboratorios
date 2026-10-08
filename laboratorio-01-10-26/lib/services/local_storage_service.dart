import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  // Claves de SharedPreferences
  static const String _keyLastUser = 'LAST_USER';
  static const String _keyRememberUser = 'REMEMBER_USER';

  // Clave de Flutter Secure Storage
  static const String _keyAuthToken = 'AUTH_TOKEN_SECURE';

  final FlutterSecureStorage _secureStorage =
      const FlutterSecureStorage();

  // ---------------------------------------------
  // SHAREDPREFERENCES - DATOS NO SENSIBLES
  // ---------------------------------------------

  // Guardar último usuario
  Future<void> saveLastUser(String user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLastUser, user);
  }

  // Obtener último usuario
  Future<String> getLastUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyLastUser) ?? '';
  }

  // Guardar preferencia "Recordar Usuario"
  Future<void> setRememberUser(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyRememberUser, value);
  }

  // Obtener preferencia "Recordar Usuario"
  Future<bool> getRememberUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyRememberUser) ?? false;
  }

  // ---------------------------------------------
  // FLUTTER SECURE STORAGE - DATOS SENSIBLES
  // ---------------------------------------------

  // Guardar Token JWT
  Future<void> saveAuthToken(String token) async {
    await _secureStorage.write(
      key: _keyAuthToken,
      value: token,
    );
  }

  // Obtener Token JWT
  Future<String?> getAuthToken() async {
    return await _secureStorage.read(
      key: _keyAuthToken,
    );
  }

  // Borrar únicamente el Token JWT
  Future<void> deleteAuthToken() async {
    await _secureStorage.delete(
      key: _keyAuthToken,
    );
  }
}