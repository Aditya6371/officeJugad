import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zero_admin/res/res.dart';

class EmptyPlaceholder extends StatelessWidget {
  const EmptyPlaceholder({
    super.key,
    this.title = 'Not Found',
  });

  final String? title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SvgPicture.asset(AssetConstants.noTicketPlaceholder),
          Text(
            title!,
            style: Styles.black14.copyWith(fontWeight: FontWeight.w400),
          ),
          Dimens.boxHeight24,
        ],
      ),
    );
  }
}
