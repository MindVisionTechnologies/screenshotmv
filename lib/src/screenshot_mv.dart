// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

class ScreenshotMv extends StatelessWidget {
  final Widget child;
  final String name;
  const ScreenshotMv({super.key, required this.child, required this.name});

  @override
  Widget build(BuildContext context) {
    ScreenshotController screenshotController = ScreenshotController();
    void downloadImage(Uint8List imageBytes, String fileName) {
      // Create a Blob object from the image data
      final blob = Blob([imageBytes]);

      // Create a download URL for the Blob
      final downloadUrl = Url.createObjectUrlFromBlob(blob);

      // Create a link element with the download and href attributes set to the download URL
      final link = AnchorElement()
        ..download = fileName
        ..href = downloadUrl;

      // Programmatically click the link element to start the download
      link.click();

      // Revoke the URL to free up resources
      Url.revokeObjectUrl(downloadUrl);
    }

    return InkWell(
      onTap: () {
        screenshotController
            .capture(delay: const Duration(milliseconds: 10))
            .then((capturedImage) async {
          // ShowCapturedWidget(context, capturedImage!);
          downloadImage(capturedImage!, "$name.png");
        }).catchError((onError) {});
      },
      child: Screenshot(
        controller: screenshotController,
        child: child,
      ),
    );
  }
}
