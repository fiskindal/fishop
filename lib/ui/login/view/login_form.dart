import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishop/core/constants/enums/locale_keys_enum.dart';
import 'package:fishop/core/init/localstorage/localstorage.dart';
import 'package:fishop/ui/login/cubit/login_cubit.dart';
import 'package:fishop_firebase/fishop_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:kartal/kartal.dart';
import 'package:fi_widget/fi_widget.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        } else if (state.status.isSubmissionSuccess) {
          GoRouter.of(context).go('/');
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 2),
        child: SingleChildScrollView(
          child: Container(
            height: context.height / 1.5,
            child: SignupForm(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35), topRight: Radius.circular(35)),
            ),
          ),
        ),
      ),
    );
  }
}

class SignupForm extends StatelessWidget {
  const SignupForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: context.paddingLow,
          child: Text('Email address'),
        ),
        Padding(
          padding: context.paddingLow,
          child: _EmailInput(),
        ),
        Padding(
          padding: context.paddingLow,
          child: Text('Password'),
        ),
        Padding(
          child: _PasswordInput(),
          padding: context.paddingLow,
        ),
        Padding(
          child: _LoginButton(),
          padding: context.paddingLow,
        ),
        Padding(
          child: _SignUpButton(),
          padding: context.paddingMedium,
        ),
      ],
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('email_input'),
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecorationExtension.defaultInputDecoration(
            context,
            errorText: state.email.invalid ? 'invalid email' : null,
            boxConstraintsMaxWidth: context.width / 1.01,
            hintText: 'Enter Email Addres',
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
            key: const Key('password_input'),
            onChanged: (password) =>
                context.read<LoginCubit>().passwordChanged(password),
            obscureText: true,
            decoration: InputDecorationExtension.defaultInputDecoration(context,
                errorText: state.password.invalid ? 'invalid password' : null,
                hintText: 'Enter password',
                boxConstraintsMaxWidth: context.width / 1.01));
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) async {
        if (state.status.isSubmissionSuccess == true) {
          LocaleManager locale = LocaleManager.instance;
          locale.setBoolValue(PreferencesKeys.USER_IS_LOGGED_IN, true);
        }
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key('login_button'),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: state.status.isValidated
                    ? () => context.read<LoginCubit>().logInWithCredentials()
                    : null,
                child: const Text('LOGIN'),
              );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      key: const Key('createAccount'),
      onPressed: () => GoRouter.of(context).go('/signup'),
      child: Text(
        'CREATE ACCOUNT',
      ),
    );
  }
}
