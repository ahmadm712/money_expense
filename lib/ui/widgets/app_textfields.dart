import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:money_expense/helpers/app_helpers.dart';
import 'package:money_expense/styles.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry contentPadding;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color labelColor;
  final TextStyle? textStyle;
  final bool isCurrency;

  const AppTextField({
    super.key,
    required this.controller,
    this.hint,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    this.isCurrency = false,
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
    this.borderColor = AppColors.grey,
    this.focusedBorderColor = AppColors.grey,
    this.labelColor = AppColors.darkGrey,
    this.textStyle = AppStyles.bodyMedium,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      onChanged: (val) {
        if (isCurrency) {
          final newText = formatToRupiahTextField(val);
          if (newText != controller.text) {
            final cursorPos = newText.length;
            controller.value = TextEditingValue(
              text: newText,
              selection: TextSelection.collapsed(offset: cursorPos),
            );
          }
        }
        onChanged?.call(val);
      },
      style: textStyle,
      decoration: InputDecoration(
        hintText: hint ?? (isCurrency ? 'Rp 0' : null),
        labelStyle: TextStyle(
          color: labelColor,
          fontWeight: FontWeight.bold,
        ),
        contentPadding: contentPadding,
        isDense: true,
        filled: true,
        fillColor: Colors.white,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.grey5),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: focusedBorderColor, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
