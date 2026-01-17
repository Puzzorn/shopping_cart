import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLoginStarted extends AuthEvent {
  final String username;
  final String password;

  const AuthLoginStarted({required this.username, required this.password});

  @override
  List<Object> get props => [username, password];
}

class AuthCheckRequested extends AuthEvent {}

class AuthLogoutClicked extends AuthEvent {}
