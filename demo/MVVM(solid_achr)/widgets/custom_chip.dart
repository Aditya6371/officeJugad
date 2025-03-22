import 'package:flutter/material.dart';
import 'package:zero_admin/res/res.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.title,
    this.color,
    this.backgrouncolor,
    required this.onpress,
    this.isSelected = false,
    this.showCheckmark = true,
  });
  final String title;
  final Color? color;
  final Color? backgrouncolor;
  final void Function() onpress;
  final bool isSelected;
  final bool showCheckmark;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: FilterChip(
        checkmarkColor: ColorsValue.primaryColor,
        selectedColor: ColorsValue.primaryColor.withOpacity(0.1),
        selected: isSelected,
        onSelected: (val) {
          onpress();
        },
        showCheckmark: showCheckmark,
        labelPadding: Dimens.edgeInsets16_0_16_0,
        label: Text(
          title,
          style: Styles.black12w500.copyWith(
              color: color ??
                  (isSelected ? ColorsValue.primaryColor : Colors.black)),
        ),
        backgroundColor: backgrouncolor,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: ColorsValue.black),
          borderRadius: BorderRadius.circular(Dimens.fifty),
        ),
      ),
    );
  }
}
