import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:qr_flutter/qr_flutter.dart';




class QRGeneratorScreen extends StatelessWidget {
  final String phoneNumber = "+1234567890"; // Change this to the desired phone number

   // Function to make a phone call
  Future<void> _makeCall(String phoneNumber) async {
    Uri uri = Uri.parse("tel:$phoneNumber");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not call $phoneNumber";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("QR Code Generator")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Scan this QR to Call",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            /// ✅ QR Code Generator
            GestureDetector(
              onTap: () => _makeCall(phoneNumber),
              child: QrImageView(
                data: "tel:$phoneNumber",
                version: QrVersions.auto,
                size: 200.0,
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
