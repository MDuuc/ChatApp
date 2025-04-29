import 'dart:convert';

import 'package:flutter_app/features.auth/data/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthRemoteDataSource {
  final String baseUrl = 'http://localhost:5000/auth';

Future<UserModel> login({required String email, required String password}) async {
  final response = await http.post(
    Uri.parse('$baseUrl/login'),
    body: jsonEncode({'email': email, 'password': password}),
    headers: {'Content-Type': 'application/json'},
  );
  //   print(response.body);
  // print(response.statusCode);
    if (response.statusCode == 200) {
   final json = jsonDecode(response.body);
        final user = UserModel.fromJson(json['user']);
        await user.saveToken();
        return user;
} else {
  throw Exception('Failed to login. Status code: ${response.statusCode}');
}


}

Future<UserModel> register({required String username, required String email, required String password}) async {
  final response = await http.post(
    Uri.parse('$baseUrl/register'),
    body: jsonEncode({'username': username, 'email': email, 'password': password}),
    headers: {'Content-Type': 'application/json'},
  );
  // print(response.body);
  // print(response.statusCode);

    if (response.statusCode == 201) {
      final json = jsonDecode(response.body);
        return UserModel.fromJson(json['user']);
} else {
  throw Exception('Failed to login. Status code: ${response.statusCode}');
}
}
}