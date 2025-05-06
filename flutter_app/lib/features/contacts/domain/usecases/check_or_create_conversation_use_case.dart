import 'package:flutter_app/features/conversation/domain/repositories/conversation_repository.dart';

class CheckOrCreateConversationUseCase {
  final ConversationsRepository conversationsRepository;

  CheckOrCreateConversationUseCase({required this.conversationsRepository});

  Future<String> call({required String contactId}) async {
    return conversationsRepository.checkOrCreateConversation(contactId);
  }
}