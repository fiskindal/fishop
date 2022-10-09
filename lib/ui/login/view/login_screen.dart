import 'package:fishop/ui/login/cubit/login_cubit.dart';
import 'package:fishop/ui/login/view/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fishop_firebase/fishop_firebase.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('login_screen'),
      backgroundColor: Color(0xFFF6F6F6),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider(
          create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
          child: const LoginForm(),
        ),
      ),
    );
  }
}
