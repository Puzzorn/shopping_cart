import 'package:dio/dio.dart';
import '../../domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> login(String username, String password);
  Future<User> getUserProfile(int id);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await dio.post(
      '/auth/login',
      data: {'username': username, 'password': password},
    );
    return response.data; // Expected { "token": "..." }
  }

  @override
  Future<User> getUserProfile(int id) async {
    // FakeStoreAPI /users/1 returns a full user object
    final response = await dio.get('/users/$id');
    final data = response.data;

    // Mapping here for simplicity, typically done in a Model class
    return User(
      id: data['id'],
      username: data['username'],
      email: data['email'],
      address: '${data['address']['city']}, ${data['address']['street']}',
    );
  }
}
