import 'package:auto_route/annotations.dart';
import 'package:beomy_login/auth/bloc/bloc.dart';
import 'package:beomy_login/auth/bloc/event.dart';
import 'package:beomy_login/ui/style/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          InkWell(
              onTap: () => context.read<AuthBloc>().add(LogoutEvent()),
              child: Icon(
                Icons.logout,
                color: ColorsApp.primary,
              ))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "BeomyTech",
              textAlign: TextAlign.center,
              style: TextStyle(color: ColorsApp.primary, fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            user.displayName ?? "Unknown name",
            style:
                DefaultTextStyle.of(context).style.copyWith(color: ColorsApp.primary, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
