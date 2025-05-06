import 'package:flutter_app/features/conversation/domain/entities/conversation_entity.dart';

class ConversationModel extends ConversationEntity {
  ConversationModel({
    required super.id,
    required super.participantName,
    super.lastMessage, 
    super.lastMessageTime, 
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['conversation_id'] as String,
      participantName: json['participant_name'] as String,
      lastMessage: json['last_message'] as String?, // Nullable
      lastMessageTime: json['last_message_time'] != null
          ? DateTime.parse(json['last_message_time'])
          : null, 
    );
  }
}