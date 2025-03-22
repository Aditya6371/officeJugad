import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:zero_admin/controllers/controllers.dart';
import 'package:zero_admin/res/res.dart';

class SplashView extends StatelessWidget {
  SplashView({super.key});

  final controller = Get.find<SplashController>();

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ColorsValue.primaryColor,
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.5),
                  blurRadius: 40,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: SvgPicture.asset(
              AssetConstants.appLogo,
              fit: BoxFit.cover,
              height: Get.height * .5,
              width: Get.width * .9,
            ),
          ).animate().fadeIn(
                duration: const Duration(
                  seconds: 3,
                ),
              ),
        ),
      );
}
