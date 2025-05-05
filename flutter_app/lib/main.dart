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

  runApp( MyApp(authRepositoryImpl: authRepositoryImpl, conversationsRepositoryImpl: conversationsRepositoryImpl, messagesRepository: messagesRepository,));
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepositoryImpl;
  final ConversationsRepositoryImpl conversationsRepositoryImpl;
  final MessagesRepositoryImpl messagesRepository;


  const MyApp({super.key, required this.authRepositoryImpl, required this.conversationsRepositoryImpl, required this.messagesRepository});

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
        },
      ),
    );
  }
}

