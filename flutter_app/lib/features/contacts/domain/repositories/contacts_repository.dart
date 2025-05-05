import 'package:flutter_app/features/contacts/domain/entities/contact_entity.dart';

abstract class ContactsRepository {
  Future<List<ContactEntity>> fetchContacts();
  Future<void> addContact({required String email});
}