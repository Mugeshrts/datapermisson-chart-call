import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_monetering/home/homeevent.dart';
import 'package:tank_monetering/home/homestate.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(Authenticated()) {
    on<LogoutEvent>((event, emit) {
      emit(Unauthenticated());
    });
  }
}