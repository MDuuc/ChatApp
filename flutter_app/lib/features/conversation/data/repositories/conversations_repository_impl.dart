import 'package:flutter_app/features/conversation/data/datasources/conversation_remote_data_source.dart';
import 'package:flutter_app/features/conversation/data/models/conversation_model.dart';
import 'package:flutter_app/features/conversation/domain/repositories/conversation_repository.dart';

class ConversationsRepositoryImpl implements ConversationsRepository {
  final ConversationsRemoteDataSource remoteDataSource;

  ConversationsRepositoryImpl({required this.remoteDataSource,});

  @override
  Future<List<ConversationModel>> fetchConversations() async {
    return await remoteDataSource.fetchConversations();
  }
  
  @override
  Future<String> checkOrCreateConversation(String contactId) async {
    return await remoteDataSource.checkOrCreateConversation( contactId);
  }
}
