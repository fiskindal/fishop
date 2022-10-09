import 'package:fishop/app/bloc/app_bloc.dart';
import 'package:fishop_firebase/fishop_firebase.dart';
import 'package:fishop/l10n/l10n.dart';
import 'package:fishop/ui/home/view/home_screen.dart';
import 'package:fishop/ui/login/cubit/login_cubit.dart';
import 'package:fishop/ui/login/view/login_screen.dart';
import 'package:fishop/ui/signup/view/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:fi_theme/fi_theme.dart';
import 'package:formz/formz.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required AuthenticationRepository authenticationRepository,
  }) : _authenticationRepository = authenticationRepository;
  final AuthenticationRepository _authenticationRepository;
  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      routes: <GoRoute>[
        GoRoute(
          path: '/',
          builder: (context, state) {
            return RepositoryProvider.value(
              value: _authenticationRepository,
              child: LoginPage(),
            );
          },
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) {
            return RepositoryProvider.value(
              value: _authenticationRepository,
              child: SignupPage(),
            );
          },
        ),
        GoRoute(
          path: '/home',
          builder: (context, state) {
            return HomeScreen();
          },
        )
      ],
    );
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      theme: FiTheme().myTheme,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}
