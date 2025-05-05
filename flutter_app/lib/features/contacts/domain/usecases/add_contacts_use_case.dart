import 'package:flutter_app/features/contacts/domain/repositories/contacts_repository.dart';

class AddContactsUseCase {
  final ContactsRepository contactsRepository;

  AddContactsUseCase({required this.contactsRepository});

  Future<void> call({required String email}) async {
    return await contactsRepository.addContact(email: email);
  }
}