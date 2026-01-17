import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String username, String password);
  Future<User> getUserProfile();
  Future<void> logout();
  Future<User?> checkAuth();
}
