import '../services/user_service.dart';

class UserRepository {
  final UserService _apiService = UserService();

  Future<Map<String, dynamic>> fetchUserProfile(int userId) async {
    try {
      final data = await _apiService.getUserProfile(userId);
      return data;
    } catch (e) {
      throw Exception('Error en UserRepository: $e');
    }
  }
}