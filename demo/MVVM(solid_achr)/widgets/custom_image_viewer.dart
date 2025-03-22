import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomImageView extends StatelessWidget {
  CustomImageView({super.key});

  final type = (Get.arguments as Map<String, dynamic>)['type'] as String;
  final pickedImage =
      (Get.arguments as Map<String, dynamic>)['path'] ?? File('path');
  final url = (Get.arguments as Map<String, dynamic>)['url'] as String;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.white,
        child: Center(
          child: (type == 'url')
              ? Image.network(
                  url,
                  errorBuilder: (c, o, s) {
                    return const Text('Something is wrong with this file.');
                  },
                )
              : Image.file(
                  pickedImage,
                  errorBuilder: (c, o, s) {
                    return const Text('Something is wrong with this file.');
                  },
                ),
        ),
      ),
    );
  }
}
