import 'package:flutter_app/features/chat/data/datasources/message_remote_data_source.dart';
import 'package:flutter_app/features/chat/domain/entities/message_entity.dart';
import 'package:flutter_app/features/chat/domain/repositories/message_repository.dart';

class MessagesRepositoryImpl implements MessagesRepository {
  final MessagesRemoteDataSource remoteDataSource;

  MessagesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<MessageEntity>> fetchMessages(String conversationId) {
    return remoteDataSource.fetchMessages(conversationId);
  }

  @override
  Future<void> sendMessage(MessageEntity message) {
    throw UnimplementedError();
  }
}