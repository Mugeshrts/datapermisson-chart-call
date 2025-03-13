import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tank_monetering/home/homeui.dart';
import 'package:tank_monetering/login.dart';
import 'package:tank_monetering/splash/splashbloc.dart';


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ConnectivityBloc()..add(CheckConnectivity()),
      child: BlocListener<ConnectivityBloc, ConnectivityState>(
        listener: (context, state) {
          if (state is ConnectivityConnected) {
            Future.delayed(Duration(seconds: 2), () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            });
          } else if (state is ConnectivityDisconnected) {
            _showNoInternetDialog(context);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.blue,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.flash_on, size: 80, color: Colors.white),
                SizedBox(height: 20),
                Text("My App", style: TextStyle(fontSize: 24, color: Colors.white)),
                SizedBox(height: 20),
                BlocBuilder<ConnectivityBloc, ConnectivityState>(
                  builder: (context, state) {
                    if (state is ConnectivityChecking) {
                      return CircularProgressIndicator(color: Colors.white);
                    }
                    return SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showNoInternetDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("No Internet Connection"),
        content: Text("Please check your internet connection and try again."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<ConnectivityBloc>().add(CheckConnectivity());
            },
            child: Text("Retry"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}
