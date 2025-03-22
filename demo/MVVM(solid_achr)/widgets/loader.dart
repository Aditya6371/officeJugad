import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) => UnconstrainedBox(
        child: Container(
          height: Get.width * .2,
          width: Get.width * .2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Theme.of(context).hintColor.withOpacity(.3),
          ),
          child: Center(
            child: CircularProgressIndicator.adaptive(
              backgroundColor: GetPlatform.isAndroid
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).canvasColor,
              valueColor: const AlwaysStoppedAnimation<Color>(
                Colors.white60,
              ),
            ),
          ),
        ),
      );
}
