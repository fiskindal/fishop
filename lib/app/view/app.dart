import 'package:firebase_auth/firebase_auth.dart';
import 'package:fishop/core/constants/enums/locale_keys_enum.dart';
import 'package:fishop/core/init/localstorage/localstorage.dart';
import 'package:fishop/ui/product/product-detail/view/product_detail.dart';
import 'package:fishop_firebase/fishop_firebase.dart';
import 'package:fishop/l10n/l10n.dart';
import 'package:fishop/ui/home/view/home_screen.dart';
import 'package:fishop/ui/login/view/login_screen.dart';
import 'package:fishop/ui/signup/view/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:fi_theme/fi_theme.dart';

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
          path: '/login',
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
          path: '/',
          builder: (context, state) {
            final firebaseUser = FirebaseAuth.instance.currentUser;
            LocaleManager localeManager = LocaleManager.instance;
            if (firebaseUser?.uid != null ||
                localeManager.getBoolValue(PreferencesKeys.USER_IS_LOGGED_IN) ==
                    true) {
              return HomeScreen();
            } else {
              return RepositoryProvider.value(
                value: _authenticationRepository,
                child: LoginPage(),
              );
            }
          },
        ),
        GoRoute(
          path: '/product/:productDetailId',
          builder: (context, state) {
            return ProductDetails(id: state.extra as String);
          },
        )
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}
