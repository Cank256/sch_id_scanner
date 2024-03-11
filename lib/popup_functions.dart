import 'package:flutter/material.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:webview_flutter/webview_flutter.dart';

void showIdScanSuccess(BuildContext context, String url) async {
  ArtSweetAlert.show(
    context: context,
    artDialogArgs: ArtDialogArgs(
      type: ArtSweetAlertType.success,
      title: "Success",
      text: "The ID has been scanned successfully.",
      // Add a custom button
      showCancelBtn: true,
      confirmButtonText: 'View Profile',
      cancelButtonText: 'Close',
      onConfirm: () {
        // Close the alert dialog
        Navigator.of(context).pop();
        // Navigate to a new screen with the webview
        _navigateToWebView(context, url);
      },
    ),
  );
}

void _navigateToWebView(BuildContext context, String url) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(title: Text('Profile')),
        body: WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    ),
  );
}

void showIdScanLimitError(BuildContext context, String id) async {
  ArtSweetAlert.show(
    context: context,
    artDialogArgs: ArtDialogArgs(
      type: ArtSweetAlertType.danger,
      title: "Error",
      text: "The ID $id has reached daily scan limit.",
    )
  );
}

void showIdScanFormatError(BuildContext context) async {
  ArtSweetAlert.show(
    context: context,
    artDialogArgs: ArtDialogArgs(
      type: ArtSweetAlertType.danger,
      title: "Error",
      text: "No ID number found in the scanned data.",
    )
  );
}
