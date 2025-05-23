import 'dart:convert';
import 'package:flutter_app/features/conversation/data/models/conversation_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ConversationsRemoteDataSource {
  final String baseUrl = 'http://10.0.2.2:5000';
  final storage = FlutterSecureStorage();

Future<List<ConversationModel>> fetchConversations() async {
  String? token = await storage.read(key: 'token');

  if (token == null || token.isEmpty) {
    throw Exception('Token is missing. Please login again.');
  }

  final response = await http.get(
    Uri.parse('$baseUrl/conversations'),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    List data = jsonDecode(response.body);
    return data.map((json) => ConversationModel.fromJson(json)).toList();
  }
  
  throw Exception('Failed to fetch conversations. Status code: ${response.statusCode}');
}

Future <String> checkOrCreateConversation (String contactId) async{
  String? token = await storage.read(key: 'token');
  final response = await http.post(
  Uri.parse('${baseUrl}/conversations/check-or-create'),
  body: jsonEncode({'contactId': contactId}),
  headers: {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token',
  },
);

if (response.statusCode == 200) {
  var data = jsonDecode(response.body);
  return data['conversationId'];
} else {
  throw Exception('Failed to check or create conversations');
}
}
}