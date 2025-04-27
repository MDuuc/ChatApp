import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme.dart';
import 'package:flutter_app/features.auth/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_app/features.auth/data/repositories/auth_repository_impl.dart';
import 'package:flutter_app/features.auth/domain/usecases/login_use_case.dart';
import 'package:flutter_app/features.auth/domain/usecases/register_use_case.dart';
import 'package:flutter_app/features.auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_app/features.auth/presentation/pages/auth/login_page.dart';
import 'package:flutter_app/features.auth/presentation/pages/auth/register_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final authRepositoryImpl = AuthRepositoryImpl(authRemoteDataSource: AuthRemoteDataSource());
  runApp( MyApp(authRepositoryImpl: authRepositoryImpl,));
}

class MyApp extends StatelessWidget {
  final AuthRepositoryImpl authRepositoryImpl;
  const MyApp({super.key, required this.authRepositoryImpl});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
         create: (_) => AuthBloc(registerUseCase: RegisterUseCase(repository: authRepositoryImpl), loginUseCase: LoginUseCase(repository: authRepositoryImpl))
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
        },
      ),
    );
  }
}

