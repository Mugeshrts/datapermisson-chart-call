import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneCallScreen extends StatelessWidget {
  final String phoneNumber = "tel:+916382414638"; // Ensure correct format

  Future<void> _makePhoneCall() async {
    Uri uri = Uri.parse(phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      print("Could not launch $phoneNumber");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Phone Call Example")),
      body: Center(
        child: ElevatedButton.icon(
          icon: Icon(Icons.call),
          label: Text("Call Now"),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            textStyle: TextStyle(fontSize: 18),
            backgroundColor: Colors.green,
          ),
          onPressed: _makePhoneCall,
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PhoneCallScreen(),
  ));
}
