import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AuthState {}

class InitAuthState extends AuthState {}
class LoadingAuthState extends AuthState {}

class AuthorizedState extends AuthState {
 final User user;
 AuthorizedState(this.user);
}
class AuthErrorState extends AuthState {
 final String message;
  AuthErrorState(this.message);
}
class LogoutErrorState extends AuthState {
 final String message;
 LogoutErrorState(this.message);
}