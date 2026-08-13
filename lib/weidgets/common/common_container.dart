import 'package:flutter/material.dart';

Widget commonContainer({
  required Widget child,
  EdgeInsetsGeometry? padding,
  EdgeInsetsGeometry? margin,
  Color? color,
  double borderRadius = 12,
  double? width,
  double? height,
  Border? border,
  List<BoxShadow>? boxShadow,
  Alignment? alignment,
}) {
  return Container(
    width: width,
    height: height,
    alignment: alignment,
    padding: padding ?? const EdgeInsets.all(16),
    margin: margin,
    decoration: BoxDecoration(
      color: color ?? Colors.white,
      borderRadius: BorderRadius.circular(borderRadius),
      border: border,
      boxShadow: boxShadow ??
          [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
    ),
    child: child,
  );
}