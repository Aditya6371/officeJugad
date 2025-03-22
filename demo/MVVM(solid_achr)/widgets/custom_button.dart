import 'package:flutter/material.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:get/get.dart';
import 'package:zero_admin/res/res.dart';
import 'package:zero_admin/utils/enums.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.titleWidget,
    this.title,
    this.buttonType = ButtonType.primary,
    required this.onTap,
    this.style,
    this.isDisable,
    this.color,
    this.borderColor,
    this.titleColor,
    this.borderRadius,
    this.trailing,
    this.height,
    this.width,
    this.margin,
    this.gradient,
  });

  final Widget? titleWidget;
  final String? title;
  final TextStyle? style;
  final ButtonType? buttonType;
  final Function() onTap;
  final bool? isDisable;
  final Color? color;
  final Color? borderColor;
  final Color? titleColor;
  final double? borderRadius;
  final double? height;
  final double? width;
  final Widget? trailing;
  final EdgeInsets? margin;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: ScaleTap(
          onPressed: isDisable == true ? null : onTap,
          child: Container(
            margin: margin,
            height: height ?? Dimens.fourtySeven,
            width: width ?? Get.width,
            alignment: Alignment.centerRight,
            constraints: const BoxConstraints(
              maxHeight: 65,
            ),
            decoration: BoxDecoration(
              gradient: gradient,
              color: buttonType == ButtonType.primary
                  ? isDisable == true
                      ? color?.withOpacity(.6) ??
                          ColorsValue.btnColor.withOpacity(.6)
                      : color ?? ColorsValue.btnColor
                  : color ?? Colors.white,
              borderRadius:
                  BorderRadius.circular(borderRadius ?? Dimens.twelve),
              border: Border.all(
                color: borderColor ??
                    (buttonType == ButtonType.secondary
                        ? ColorsValue.btnColor
                        : Colors.transparent),
                width: 1.5,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: trailing != null
                          ? Dimens.edgeInsets24_0_0_0
                          : Dimens.edgeInsets0,
                      child: titleWidget ??
                          Text(
                            title!,
                            style: style ??
                                Styles.white18w700.copyWith(
                                  color: titleColor ??
                                      (buttonType == ButtonType.primary
                                          ? Colors.white
                                          : ColorsValue.btnColor),
                                  fontSize: Dimens.sixteen,
                                ),
                            textAlign: TextAlign.center,
                          ),
                    ),
                  ),
                ),
                if (trailing != null)
                  Padding(
                    padding: Dimens.edgeInsets0_0_5_0,
                    child: trailing,
                  ),
              ],
            ),
          ),
        ),
      );
}
