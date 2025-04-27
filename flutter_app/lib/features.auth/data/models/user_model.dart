import 'package:flutter_app/features.auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.id, required super.username,required super.email, required String token});

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(id: json['id'], username: json['username'], email: json['email'], token: json['token']??'');
  }
}