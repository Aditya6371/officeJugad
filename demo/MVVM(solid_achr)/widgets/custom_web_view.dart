import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zero_admin/res/res.dart';
import 'package:zero_admin/widgets/widgets.dart';

class CustomWebView extends StatelessWidget {
  const CustomWebView({
    required this.title,
    required this.url,
    this.onTap, // Optional onTap parameter
    super.key,
  });

  final String title;
  final String url;
  final VoidCallback? onTap; // onTap is optional

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: onTap ?? () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 26,
          ),
        ),
        title: Text(
          title,
          style: Styles.black18w600,
        ),
        centerTitle: true,
      ),
      body: HtmlViewer(
        url: url,
      ),
    );
  }
}
