import 'package:fishop_firebase/fishop_firebase.dart';
import 'package:fishop/ui/signup/cubit/signup_cubit.dart';
import 'package:fishop/ui/signup/view/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocProvider<SignUpCubit>(
          create: (_) => SignUpCubit(context.read<AuthenticationRepository>()),
          child: const SignUpForm(),
        ),
      ),
    );
  }
}
