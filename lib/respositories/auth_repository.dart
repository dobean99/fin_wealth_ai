import 'package:dio/dio.dart';

class AuthRepository {
  final Dio dio;

  AuthRepository({required this.dio});

  Future<Map<String, dynamic>> authenticate(
      String username, String password) async {
    final response = await dio.post(
      'https://finwealth.vn/api/login/',
      data: {'username': username, 'password': password},
    );
    if (response.statusCode != null) {
      final responseData = response.data;
      return responseData;
    } else {
      throw Exception('Failed to login');
    }
  }
}
