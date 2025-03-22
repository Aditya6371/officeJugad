import 'package:flutter/material.dart';
import 'package:zero_admin/res/res.dart';

class CustomDropdown extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final String? value;
  final List<String> items;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;
  final bool isRequired;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? contentPadding;
  final double? width;

  const CustomDropdown({
    super.key,
    this.labelText,
    this.hintText,
    required this.items,
    required this.onChanged,
    this.value,
    this.validator,
    this.isRequired = false,
    this.labelStyle,
    this.hintStyle,
    this.contentPadding,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText != null) ...[
          Row(
            children: [
              Text(
                labelText!,
                style: labelStyle ??
                    Styles.black12w500.copyWith(
                      color: Colors.grey[700],
                    ),
              ),
              if (isRequired)
                Text(
                  ' *',
                  style: Styles.black12w500.copyWith(
                    color: Colors.red,
                  ),
                ),
            ],
          ),
          Dimens.boxHeight8,
        ],
        Container(
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.grey[300]!,
            ),
          ),
          child: DropdownButtonFormField<String>(
            value: value,
            hint: Text(
              hintText ?? 'Select',
              style: hintStyle ??
                  Styles.grey11.copyWith(
                    fontSize: 14,
                  ),
            ),
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey[600],
            ),
            decoration: InputDecoration(
              contentPadding: contentPadding ??
                  const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              isDense: true,
            ),
            style: Styles.black12w400,
            isExpanded: true,
            validator: validator ??
                (isRequired
                    ? (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      }
                    : null),
            items: items.map<DropdownMenuItem<String>>((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: Styles.black12w400,
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
