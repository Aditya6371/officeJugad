import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateDialog extends StatelessWidget {
  final bool isMandatory;
  final Function()? onTapLater;

  const UpdateDialog({super.key, required this.isMandatory, this.onTapLater});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !isMandatory,
      child: AlertDialog(
        title: const Text('Update Available'),
        content: Text(isMandatory
            ? 'A new version of the app is available. Please update the app.'
            : 'A new version of the app is available. Would you like to update now?'),
        actions: [
          if (!isMandatory)
            TextButton(
              onPressed: () {
                Get.back();
                onTapLater!();
              },
              child: const Text('Later'),
            ),
          TextButton(
            onPressed: () {
              _launchUpdate();
            },
            child: const Text('Update Now'),
          ),
        ],
      ),
    );
  }

  void _launchUpdate() {
    if (GetPlatform.isAndroid) {
      launchUrl(Uri.parse(
          'https://play.google.com/store/apps/details?id=com.wedium.customer'));
    } else {
      launchUrl(Uri.parse('https://apps.apple.com/in/app/wedium/id6444660891'));
    }
  }
}

void showUpdateDialog(bool isMandatory, {Function()? onTapLater}) {
  Get.dialog(
    UpdateDialog(
      isMandatory: isMandatory,
      onTapLater: onTapLater,
    ),
    barrierDismissible: !isMandatory,
  );
}
