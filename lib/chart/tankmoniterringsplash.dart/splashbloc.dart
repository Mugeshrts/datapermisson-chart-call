// import 'dart:io';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:bloc/bloc.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:equatable/equatable.dart';

// abstract class SplashEvent {}

// class SplashStarted extends SplashEvent {}

// abstract class SplashState {}

// class SplashInitial extends SplashState {}

// class SplashLoading extends SplashState {}

// class SplashLoaded extends SplashState {}

// class SplashError extends SplashState {}

// class BlocSplash extends Bloc<SplashEvent, SplashState> {
//   BlocSplash() : super(SplashInitial()) {
//     on<SplashStarted>(_onSplashStarted);
//   }

// Future<void> _onSplashStarted(
//   SplashStarted event,
//   Emitter<SplashState> emit,
// ) async {
 
//   print("🔄 SplashLoading: Checking internet connection...");

//   var connectivityResult = await Connectivity().checkConnectivity();
//   bool isConnected = await _hasInternetAccess();

//   if (connectivityResult == ConnectivityResult.none || !isConnected) {
//     print("❌ SplashError: No internet connection.");
//     emit(SplashError());
//   } else {
//     print("✅ SplashLoaded: Internet connected.");
//     await Future.delayed(Duration(seconds: 1));
//     emit(SplashLoaded());
//   }
// }


//   Future<bool> _hasInternetAccess() async {
//     try {
//       final result = await InternetAddress.lookup('google.com');
//       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//         return true;
//       }
//     } catch (e) {
//       return false;
//     }
//     return false;
//   }
// }


import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class SplashEvent {}

class SplashStarted extends SplashEvent {}

abstract class SplashState {}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashLoaded extends SplashState {} // Internet available

class SplashError extends SplashState {} // No internet

class BlocSplash extends Bloc<SplashEvent, SplashState> {
  BlocSplash() : super(SplashInitial()) {
    on<SplashStarted>(_onSplashStarted);
  }

  Future<void> _onSplashStarted(
    SplashStarted event,
    Emitter<SplashState> emit,
  ) async {
    emit(SplashLoading()); // Show loader initially

    while (true) { // Keep checking connection
      bool isConnected = await _hasInternetAccess();

      if (isConnected) {
        emit(SplashLoaded());
        await Future.delayed(Duration(seconds: 2)); // Give time before navigating
        return;
      } else {
        emit(SplashError());
      }

      await Future.delayed(Duration(seconds: 2)); // Keep checking every 2 seconds
    }
  }

  Future<bool> _hasInternetAccess() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
