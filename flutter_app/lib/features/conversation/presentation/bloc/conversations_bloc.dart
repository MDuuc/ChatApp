import 'package:flutter_app/features/conversation/domain/usecases/fetch_conversation_use_case.dart';
import 'package:flutter_app/features/conversation/presentation/bloc/conversations_event.dart';
import 'package:flutter_app/features/conversation/presentation/bloc/conversations_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  final FetchConversationsUseCase fetchConversationsUseCase;

  ConversationsBloc(this.fetchConversationsUseCase) : super(ConversationsInitial()) {
    on<FetchConversations>(_onFetchConversations);
  }
  
    Future<void> _onFetchConversations(FetchConversations event, Emitter<ConversationsState> emit)  async{
      emit(ConversationsLoading());
      try {
        final conversations = await fetchConversationsUseCase();
        emit(ConversationsLoaded(conversations));
      } catch (error) {
        emit(ConversationsError('Failed to load conversations'));
      }
    }
    
      
  }

