import 'package:flutter/material.dart';
import 'package:art_sweetalert/art_sweetalert.dart';

void showIdScanSuccess(BuildContext context) async {
  ArtSweetAlert.show(
    context: context,
    artDialogArgs: ArtDialogArgs(
      type: ArtSweetAlertType.success,
      title: "Success",
      text: "The ID has been scanned successfully.",
    )
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
