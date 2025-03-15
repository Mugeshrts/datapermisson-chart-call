// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:permission_handler/permission_handler.dart'
//     as FlutterAppSettings;
// import 'package:get_storage/get_storage.dart';
// import 'package:tank_monetering/chart/tankmoniterringsplash.dart/splashbloc.dart';
// import 'package:tank_monetering/home/homeui.dart';
// import 'package:tank_monetering/landing/landingui.dart';
// import 'package:url_launcher/url_launcher.dart';

// class SplashUi extends StatelessWidget {
//   const SplashUi({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final box = GetStorage();
//     bool? savedLogin = box.read(
//       'tankmonitor_login',
//     ); // Retrieves the saved OTP verified status

//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;

//     return BlocProvider(
//       create: (context) => BlocSplash()..add(SplashStarted()),
//       child: Scaffold(
//         body: Stack(
//           children: [
//             BlocListener<BlocSplash, SplashState>(
//               listener: (context, state) {
//                 if (state is SplashError) {
//                   Fluttertoast.showToast(
//                     msg:
//                         "Please check your internet connection", // The message you want to show
//                     toastLength:
//                         Toast.LENGTH_SHORT, // Toast duration (SHORT or LONG)
//                     gravity:
//                         ToastGravity
//                             .BOTTOM, // Position of the toast (TOP, BOTTOM, CENTER)
//                     timeInSecForIosWeb: 1, // Duration for iOS (in seconds)
//                     backgroundColor:
//                         Colors.black, // Background color of the toast
//                     textColor: Colors.white, // Text color of the toast
//                     fontSize: 16.0, // Font size of the message
//                   );
//                   _showNoInternetDialog(context);
//                 }
//                 if (state is SplashLoaded) {
//                   Future.delayed(Duration(seconds: 1), () async {
//                     if (savedLogin == true) {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => TankScreen()),
//                       );
//                     } else {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => HomeScreen()),
//                       );
//                     }
//                   });
//                 }
//               },
//               child: BlocBuilder<BlocSplash, SplashState>(
//                 builder: (context, state) {
//                   if (state is SplashLoading) {
//                     return Center(child: CircularProgressIndicator());
//                   } else {
//                     return splashContent(screenWidth, screenHeight);
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// Widget splashContent(double screenWidth, double screenHeight) {
//   return Center(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         // Image.asset(
//         //   splashlogo,
//         //   width: screenWidth * 0.5,
//         //   height: screenHeight * 0.25,
//         // ),
//         SizedBox(height: 20),
//         CircularProgressIndicator(),
//       ],
//     ),
//   );
// }

// void _showNoInternetDialog(BuildContext context) {
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder:
//         (context) => AlertDialog(
//           title: Text("No Internet Connection"),
//           content: Text("Please check your internet connection and try again."),
//           actions: [
//             TextButton(
//               onPressed: () async {
//                 Navigator.pop(context);
//                 context.read<BlocSplash>().add(SplashStarted());
//               },
//               child: Text("Retry"),
//             ),

//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text("Close"),
//             ),
//           ],
//         ),
//   );
// }


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tank_monetering/chart/tankmoniterringsplash.dart/splashbloc.dart';
import 'package:tank_monetering/home/homeui.dart';
import 'package:tank_monetering/landing/landingui.dart';

class SplashUi extends StatelessWidget {
  const SplashUi({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    bool? savedLogin = box.read('tankmonitor_login');

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (context) => BlocSplash()..add(SplashStarted()),
      child: Scaffold(
        body: BlocListener<BlocSplash, SplashState>(
          listener: (context, state) {
            if (state is SplashLoaded) {
              Future.delayed(Duration(seconds: 1), () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        savedLogin == true ? TankScreen() : HomeScreen(),
                  ),
                );
              });
            }
          },
          child: BlocBuilder<BlocSplash, SplashState>(
            builder: (context, state) {
              return splashContent(screenWidth, screenHeight, state);
            },
          ),
        ),
      ),
    );
  }
}

Widget splashContent(double screenWidth, double screenHeight, SplashState state) {
  bool isConnected = state is SplashLoaded;

  return Stack(
    children: [
      /// Centered Column (Logo + Loader)
      Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Splash Logo in Center
            Image.asset(
              'assets/images/splashlogo.png', // Replace with your actual asset path
              width: screenWidth * 0.5,
              height: screenHeight * 0.25,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20), // Space between logo and loader

            /// Loader
            CircularProgressIndicator(),
          ],
        ),
      ),

      /// Internet Status Message at Bottom Center
      Positioned(
        bottom: 40, // Adjusted to be near the bottom
        left: 0,
        right: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isConnected ? Icons.check_circle : Icons.cancel,
              color: isConnected ? Colors.green : Colors.red,
              size: 24,
            ),
            SizedBox(width: 8),
            Text(
              isConnected ? "Internet Connected" : "No Internet Connection",
              style: TextStyle(
                color: isConnected ? Colors.green : Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
