import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zero_admin/res/res.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    this.focusNode,
    this.autoFocus = false,
    this.textEditingController,
    this.isObscureText = false,
    this.obscureCharacter = ' ',
    this.textCapitalization = TextCapitalization.none,
    this.isFilled,
    this.contentPadding = Dimens.edgeInsets0,
    this.fillColor,
    this.color,
    this.hintText,
    this.hintStyle,
    this.errorStyle,
    this.formBorder,
    this.focusedBorder,
    this.errorText,
    this.suffixIcon,
    this.prefixIcon,
    this.textInputAction = TextInputAction.done,
    this.textInputType = TextInputType.text,
    this.formStyle,
    required this.onChange,
    this.isReadOnly = false,
    this.onTap,
    this.errorBorder,
    this.inputFormatters,
    this.maxLength = TextField.noMaxLength,
    this.onEditingComplete,
    this.initialValue,
    this.cursorColor,
    this.maxlines = 1,
    this.enabled = true,
    this.validator,
    this.autocorrect = true,
    this.labelText,
    this.autovalidateMode,
    this.labelStyle,
  });

  final FocusNode? focusNode;
  final bool autoFocus;
  final bool autocorrect;
  final TextEditingController? textEditingController;
  final bool isObscureText;
  final String obscureCharacter;
  final TextCapitalization textCapitalization;
  final bool? isFilled;
  final EdgeInsetsGeometry contentPadding;
  final Color? fillColor;
  final Color? color;
  final String? hintText;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextStyle? errorStyle;
  final OutlineInputBorder? formBorder;
  final String? errorText;
  final String? labelText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextInputAction textInputAction;
  final TextInputType textInputType;
  final TextStyle? formStyle;
  final void Function(String value) onChange;
  final bool isReadOnly;
  final Function()? onTap;
  final InputBorder? errorBorder;
  final List<TextInputFormatter>? inputFormatters;
  final OutlineInputBorder? focusedBorder;
  final Function()? onEditingComplete;
  final int? maxLength;
  final String? initialValue;
  final Color? cursorColor;
  final int? maxlines;
  final bool? enabled;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (labelText != null)
            Column(
              children: [
                Text(
                  labelText ?? '',
                  style: labelStyle ?? Styles.black12w500,
                ),
                Dimens.boxHeight4,
              ],
            ),
          TextFormField(
            onEditingComplete: onEditingComplete,
            onTap: onTap,
            style: formStyle ?? GoogleFonts.inter(),
            readOnly: isReadOnly,
            enabled: enabled,
            obscureText: isObscureText,
            obscuringCharacter: obscureCharacter,
            cursorColor: color ?? ColorsValue.primaryColor,
            keyboardType: textInputType,
            controller: textEditingController,
            onChanged: onChange,
            validator: validator,
            inputFormatters: inputFormatters,
            autocorrect: autocorrect,
            textInputAction: textInputAction,
            autofocus: autoFocus,
            maxLines: maxlines,
            maxLength: maxLength,
            textCapitalization: textCapitalization,
            autovalidateMode: autovalidateMode,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: hintStyle,
              counterText: '',
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              focusedBorder: focusedBorder,
              enabledBorder: focusedBorder,
            ),
          ),
        ],
      );
}
