import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<User> login(String username, String password) async {
    // 1. Get Token
    final tokenData = await remoteDataSource.login(username, password);
    final token = tokenData['token'];

    // Save Token
    await localDataSource.saveToken(token);

    // 2. Mock User ID for now (As FakeStoreAPI login doesn't return ID)
    const mockUserId = 1;

    // 3. Get User Profile
    return await remoteDataSource.getUserProfile(mockUserId);
  }

  @override
  Future<User> getUserProfile() async {
    return await remoteDataSource.getUserProfile(1);
  }

  @override
  Future<void> logout() async {
    await localDataSource.deleteToken();
  }

  @override
  Future<User?> checkAuth() async {
    final token = await localDataSource.getToken();
    if (token != null) {
      try {
        // In a real app, validate token or fetch profile
        return await remoteDataSource.getUserProfile(1);
      } catch (e) {
        // If fetch fails (e.g. token expired or network), clear token
        await logout();
        return null;
      }
    }
    return null;
  }
}
