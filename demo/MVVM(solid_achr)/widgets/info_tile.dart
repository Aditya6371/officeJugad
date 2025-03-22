import 'package:flutter/material.dart';
import 'package:zero_admin/res/res.dart';

class InfoTile extends StatelessWidget {
  const InfoTile({
    super.key,
    required this.isMobile,
    required this.title,
    required this.body,
    required this.image,
    this.iconData,
    this.onPressed,
  });

  final bool isMobile;
  final String title;
  final Widget body;
  final String image;
  final Widget? iconData;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Dimens.boxWidth8,
                Image.asset(
                  image,
                  height: 30,
                ),
                Dimens.boxWidth8,
                Text(
                  title,
                  style: Styles.black16w600.copyWith(
                    fontSize: 20,
                  ),
                ),
                const Spacer(),
                if (iconData != null) ...[
                  GestureDetector(
                    onTap: onPressed,
                    child: iconData!,
                  ),
                  Dimens.boxWidth8,
                ],
              ],
            ),
          ),
          Padding(
            padding: Dimens.edgeInsets16,
            child: body,
          ),
        ],
      ),
    );
  }
}
