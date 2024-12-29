import 'package:auto_route/annotations.dart';
import 'package:beomy_login/auth/bloc/bloc.dart';
import 'package:beomy_login/auth/bloc/state.dart';
import 'package:beomy_login/ui/home_screen.dart';
import 'package:beomy_login/ui/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(InitAuthState()),
      child: BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        switch (state.runtimeType) {
          case AuthorizedState:
            return HomeScreen(user: (state as AuthorizedState).user);
          default:
            return LoginScreen();
        }
      }),
    );
  }
}
