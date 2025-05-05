import 'dart:convert';

import 'package:flutter_app/features/chat/data/models/message_models.dart';
import 'package:flutter_app/features/chat/domain/entities/message_entity.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class MessagesRemoteDataSource {
  final String baseUrl = 'http://10.0.2.2:5000';
  final storage = FlutterSecureStorage();

  Future<List<MessageEntity>> fetchMessages(String conversationId) async {
    String? token = await storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('$baseUrl/messages/$conversationId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((json) => MessageModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch messages');
    }
  }
}