import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthState {}

class Unauthenticated extends AuthState {}