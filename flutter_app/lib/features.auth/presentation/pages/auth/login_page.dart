import 'package:flutter/material.dart';
import 'package:flutter_app/core/theme.dart';
import 'package:flutter_app/features.auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_app/features.auth/presentation/bloc/auth_event.dart';
import 'package:flutter_app/features.auth/presentation/bloc/auth_state.dart';
import 'package:flutter_app/features.auth/presentation/widgets/login_register.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

    void _onlogin() {
    BlocProvider.of<AuthBloc>(context).add(
      LoginEvent(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildTextInput("Email", Icons.email, _emailController),
              buildTextInput("Password", Icons.lock, _passwordController, isPassword: true),
              const SizedBox(height: 20),
              BlocConsumer<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return buildActionButton(
                     'Login',
                     _onlogin,
                  );
                },
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    Navigator.pushNamed(context, '/register');
                  } else if (state is AuthFailure) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              buildLoginPrompt(
                "Do not have an account? ",
                "Click here to register? ",
                () {
                  Navigator.pushNamed(context, '/register');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}