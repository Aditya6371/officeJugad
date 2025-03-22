import 'package:flutter/material.dart';

import 'package:zero_admin/res/res.dart';

class NodataFound extends StatelessWidget {
  const NodataFound({
    super.key,
    required this.msg,
  });

  final String? msg;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: Dimens.edgeInsets16,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SvgPicture.asset(
          //   AssetConstants.nodatalogo,
          //   width: Get.width,
          //   height: Get.height * 0.1,
          // ),
          Dimens.boxHeight24,
          Text(
            msg ?? "",
            style: Styles.black14,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
