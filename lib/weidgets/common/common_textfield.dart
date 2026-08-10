// lib/common/widgets/text_fields/common_text_field.dart
import 'package:flutter/material.dart';

Widget commonTextField({
  required TextEditingController controller,
  String? label,
  String? hint,
  bool obscureText = false,
  TextInputType keyboardType = TextInputType.text,
  String? Function(String?)? validator,
  Widget? suffixIcon,
  Widget? prefixIcon,
  int maxLines = 1,
  bool enabled = true,
  ValueChanged<String>? onChanged,
  FocusNode? focusNode,
  double borderRadius = 10,
}) {
  return TextFormField(
    controller: controller,
    obscureText: obscureText,
    keyboardType: keyboardType,
    validator: validator,
    maxLines: obscureText ? 1 : maxLines,
    enabled: enabled,
    onChanged: onChanged,
    focusNode: focusNode,
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: enabled ? Colors.white : Colors.grey.shade200,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        // borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: Colors.blue, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        borderSide: const BorderSide(color: Colors.red, width: 1.2),
      ),
    ),
  );
}