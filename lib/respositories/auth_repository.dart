import 'package:dio/dio.dart';

class AuthRepository {
  final Dio dio;

  AuthRepository({required this.dio});

  Future<bool> authenticate(String username, String password) async {
    final response = await dio.post(
      'https://finwealth.vn/api/login/',
      data: {'username': username, 'password': password},
    );
    if (response.statusCode != null) {
      final responseData = response.data;
      return true;
    } else {
      throw Exception('Failed to login');
    }
  }
}

// class AuthRepository {
//   Future<bool> authenticate({
//     required String username,
//     required String password,
//   }) async {
//     // Fake authentication for testing purposes
//     await Future.delayed(const Duration(seconds: 2));

//     return username == 'test' && password == 'password';
//   }
// }
