import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tank_monetering/home/homebloc.dart';
import 'package:tank_monetering/home/homeevent.dart';
import 'package:tank_monetering/landing/landingui.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      drawer: _buildDrawer(context),
      body: Center(
        child: Text("Welcome to the Home Screen!", style: TextStyle(fontSize: 18)),
      ),
    );
  }

  /// ✅ Build App Drawer with Logout
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // children: [
              //   Icon(Icons.account_circle, size: 60, color: Colors.white),
              //   SizedBox(height: 10),
              //   // Text("User Name", style: TextStyle(fontSize: 18, color: Colors.white)),
              //   // Text("user@example.com", style: TextStyle(fontSize: 14, color: Colors.white70)),
              // ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.water_damage),
            title: Text("Tank Monetering"),
            onTap: () => Get.to(() => TankScreen()),
           
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () => _showLogoutDialog(context),
          ),
        ],
      ),
    );
  }

  /// ❌ Show Logout Confirmation Dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(LogoutEvent()); // Trigger logout
              Navigator.pop(context);
            },
            child: Text("Logout", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
