import 'package:flutter/material.dart';
import 'package:flutter_app/core/socket_service.dart';
import 'package:flutter_app/features/chat/data/datasources/message_remote_data_source.dart';
import 'package:flutter_app/features/chat/data/repositories/message_repository_impl.dart';
import 'package:flutter_app/features/chat/domain/usecases/fetch_message_use_case.dart';
import 'package:flutter_app/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:flutter_app/features/chat/presentation/pages/chat_page.dart';
import 'package:flutter_app/core/theme.dart';
import 'package:flutter_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_app/features/auth/domain/usecases/login_use_case.dart';
import 'package:flutter_app/features/auth/domain/usecases/register_use_case.dart';
import 'package:flutter_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_app/features/auth/presentation/pages/auth/login_page.dart';
import 'package:flutter_app/features/auth/presentation/pages/auth/register_page.dart';
import 'package:flutter_app/features/contacts/data/datasources/contacts_remote_data_source.dart';
import 'package:flutter_app/features/contacts/data/repositories/contacts_repository_impl.dart';
import 'package:flutter_app/features/contacts/domain/usecases/add_contacts_use_case.dart';
import 'package:flutter_app/features/contacts/domain/usecases/fetch_contacts_use_case.dart';
import 'package:flutter_app/features/contacts/presentation/bloc/contacts_bloc.dart';
import 'package:flutter_app/features/contacts/presentation/pages/contacts_page.dart';
import 'package:flutter_app/features/conversation/data/datasources/conversation_remote_data_source.dart';
import 'package:flutter_app/features/conversation/data/repositories/conversations_repository_impl.dart';
import 'package:flutter_app/features/conversation/domain/usecases/fetch_conversation_use_case.dart';
import 'package:flutter_app/features/conversation/presentation/bloc/conversations_bloc.dart';
import 'package:flutter_app/features/conversation/presentation/pages/conversation_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final socketService = SocketService();
  await socketService.initSocket();
  final authRepositoryImpl = AuthRepositoryImpl(authRemoteDataSource: AuthRemoteDataSource());
  final conversationsRepositoryImpl = ConversationsRepositoryImpl(remoteDataSource: ConversationsRemoteDataSource(),);
  final messagesRepository = MessagesRepositoryImpl(remoteDataSource: MessagesRemoteDataSource());
  final contactsRepository = ContactsRepositoryImpl(remoteDataSource: ContactsRemoteDataSource());


  runApp( MyApp(authRepositoryImpl: authRepositoryImpl, conversationsRepositoryImpl: conversationsRepositoryImpl, messagesRepository: messagesRepository, contactsRepository: contactsRepository,));
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepositoryImpl;
  final ConversationsRepositoryImpl conversationsRepositoryImpl;
  final MessagesRepositoryImpl messagesRepository;
  final ContactsRepositoryImpl contactsRepository;



  const MyApp({super.key, required this.authRepositoryImpl, required this.conversationsRepositoryImpl, required this.messagesRepository, required this.contactsRepository});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
         create: (_) => AuthBloc(registerUseCase: RegisterUseCase(repository: authRepositoryImpl), loginUseCase: LoginUseCase(repository: authRepositoryImpl))
        ),

        BlocProvider(
         create: (_) => ConversationsBloc( FetchConversationsUseCase(conversationsRepositoryImpl))
        ),

        BlocProvider(
         create: (_) => ChatBloc(fetchMessagesUseCase: FetchMessagesUseCase(messagesRepository: messagesRepository))
        ),

      BlocProvider(
         create: (_) => ContactsBloc(fetchContactsUseCase: FetchContactsUseCase(contactsRepository: contactsRepository), addContactUseCase: AddContactsUseCase(contactsRepository: contactsRepository) )
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
        routes: {
          '/login': (_) => LoginPage(),
          '/register': (_) => RegisterPage(),
          '/conversationPage': (_) => ConversationPage(),
          '/contactsPage': (_) => ContactsPage(),
        },
      ),
    );
  }
}

