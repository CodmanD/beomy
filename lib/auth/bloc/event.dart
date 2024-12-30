import 'package:flutter/material.dart';

@immutable
abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;

  RegisterEvent(this.email, this.password);
}

class GoogleLoginEvent extends AuthEvent {}

class FacebookLoginEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}
