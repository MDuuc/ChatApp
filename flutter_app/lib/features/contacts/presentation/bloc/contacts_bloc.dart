
import 'package:flutter_app/features/contacts/domain/usecases/add_contacts_use_case.dart';
import 'package:flutter_app/features/contacts/domain/usecases/fetch_contacts_use_case.dart';
import 'package:flutter_app/features/contacts/presentation/bloc/contacts_event.dart';
import 'package:flutter_app/features/contacts/presentation/bloc/contacts_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_app/features/contacts/domain/usecases/check_or_create_conversation_use_case.dart';


class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  final FetchContactsUseCase fetchContactsUseCase;
  final AddContactsUseCase addContactUseCase;
  final CheckOrCreateConversationUseCase checkOrCreateConversationUseCase;

  ContactsBloc({required this.fetchContactsUseCase, required this.addContactUseCase, required this.checkOrCreateConversationUseCase})
  : super(ContactsInitial()) {
  on<FetchContacts>(_onFetchContacts);
  on<AddContact>(_onAddContact);
  on<CheckOrCreateConversationEvent>(_checkOrCreateConversation);

  }

  Future<void> _onFetchContacts(FetchContacts event, Emitter<ContactsState> emit) async {
    emit(ContactsLoading());
    try {
    final contacts = await fetchContactsUseCase();
    emit(ContactsLoaded(contacts));
    } catch (error) {
    emit(ContactsError('Failed to fetch'));
    }
  }

  Future<void> _onAddContact(AddContact event, Emitter<ContactsState> emit) async {
    emit(ContactsLoading());
    try {
    await addContactUseCase(email: event.email);
    emit(ContactAdded());
    add(FetchContacts());
    } catch (error) {
      emit(ContactsError('Failed to fetch contacts'));
      }
    }

      Future<void> _checkOrCreateConversation(CheckOrCreateConversationEvent event, Emitter<ContactsState> emit) async {
        emit(ContactsLoading());
        try {
        final conversationId = await checkOrCreateConversationUseCase(contactId: event.contactId);
        emit(ConversationReady(conversationId,  event.contactName));
        } catch (error) {
        emit(ContactsError('Failed to fetch'));
        }
    }
}