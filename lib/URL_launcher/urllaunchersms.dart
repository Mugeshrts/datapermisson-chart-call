import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class QRGeneratorScreen1 extends StatelessWidget {
  final String phoneNumber = "+1234567890"; // Change this to your desired number

  // Function to make a phone call
  Future<void> _makeCall(String phoneNumber) async {
    Uri uri = Uri.parse("tel:$phoneNumber");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not call $phoneNumber";
    }
  }

  // Function to send an SMS
  Future<void> _sendSMS(String phoneNumber) async {
    Uri uri = Uri.parse("sms:$phoneNumber");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not send SMS to $phoneNumber";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Clickable QR Code (Call & SMS)")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Tap or Scan QR to Call or SMS",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            /// ✅ Clickable QR Code for Calling
            GestureDetector(
              onTap: () => _makeCall(phoneNumber), // Tap to Call
              child: QrImageView(
                data: "tel:$phoneNumber", // Scannable for calling
                version: QrVersions.auto,
                size: 150.0,
              ),
            ),

            SizedBox(height: 20),

            /// ✅ Clickable QR Code for SMS
            GestureDetector(
              onTap: () => _sendSMS(phoneNumber), // Tap to SMS
              child: QrImageView(
                data: "sms:$phoneNumber", // Scannable for SMS
                version: QrVersions.auto,
                size: 150.0,
              ),
            ),

            SizedBox(height: 20),
            Text(
              "Phone: $phoneNumber",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}