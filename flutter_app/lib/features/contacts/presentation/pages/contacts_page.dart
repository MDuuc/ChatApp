import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme.dart';
import 'package:flutter_app/features/contacts/presentation/bloc/contacts_bloc.dart';
import 'package:flutter_app/features/contacts/presentation/bloc/contacts_event.dart';
import 'package:flutter_app/features/contacts/presentation/bloc/contacts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ContactsBloc>(context).add(FetchContacts());
  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: BlocBuilder<ContactsBloc, ContactsState>(
        builder: (context, state){
          if (state is ContactsLoading){
            return Center(child: CircularProgressIndicator(),);
          }else if(state is ContactsLoaded){
            return ListView.builder(
              itemCount: state.contacts.length,
              itemBuilder: (context, index){
                final contact = state.contacts[index];
                return ListTile(
                  title: Text(contact.username, style: TextStyle(color: Colors.white),),
                  subtitle: Text(contact.email, style: TextStyle(color: DefaultColors.greyText)),
                  onTap: (){
                    Navigator.pop(context);
                  },
                );
              }
              );
          } else if (state is ContactsError){
            return Center(child: Text(state.message),);
          }
          return Center(child: Text("No contracts found"),);
        }
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _showAddContactDialog(context);
        },
        child: Icon(Icons.add),
        ),
    );
  }

  void _showAddContactDialog(BuildContext context){
    final emailController = TextEditingController();
    showDialog(
      context: context, 
      builder: (context) => AlertDialog(
        title: Text("Add contact"),
        content: TextField(
          style: TextStyle(color: Colors.black),
          controller: emailController,
          decoration: InputDecoration(hintText: 'Enter contact email'),
        ),
        actions: [
          TextButton(
            onPressed: (){
              Navigator.pop(context);
            }, 
            child: Text(
              "Cancel"
            )
            ),
            ElevatedButton(
              onPressed: (){
                final email = emailController.text.trim();
                if(email.isNotEmpty){
                  BlocProvider.of<ContactsBloc>(context).add(AddContact(email));
                  Navigator.pop(context);
                }
              }, 
              child: Text("Add")
              )
        ],
      )
      );
  }
}