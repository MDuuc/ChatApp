import 'package:flutter_app/features/conversation/domain/entities/conversation_entity.dart';
import 'package:flutter_app/features/conversation/domain/repositories/conversation_repository.dart';

class FetchConversationsUseCase {
  final ConversationsRepository repository;

  FetchConversationsUseCase(this.repository);

  Future<List<ConversationEntity>> call() async {
    return repository.fetchConversations();
  }
}