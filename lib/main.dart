import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tank_monetering/chart/chart.dart';
import 'package:tank_monetering/landing/landingbloc.dart';
import 'package:tank_monetering/splash/splashui.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure plugins are initialized
  runApp(
    BlocProvider(
      create: (context) => TankBloc()..add(LoadTanks()),  // Provide the Bloc globally
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: TankScreen1()
    );
  }
}
