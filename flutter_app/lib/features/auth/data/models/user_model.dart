import 'package:flutter_app/features/auth/domain/entities/user_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserModel extends UserEntity {
  UserModel({required super.id, required super.username,required super.email, required super.token});

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(id: json['id'], username: json['username'], email: json['email'], token: json['token']);
  }

    Future<void> saveToken() async {
    const storage = FlutterSecureStorage();
    await storage.write(key: 'token', value: token);
  }

  Future<void> saveUserId() async {
    const storage = FlutterSecureStorage();
    await storage.write(key: 'userId', value: id);
  }

    @override
  String toString() {
    return 'UserModel(id: $id , email: $email, username: $username, token: $token)';
  }
}