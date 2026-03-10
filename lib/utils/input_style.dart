import 'package:flutter/material.dart';
import 'package:travell_app/theme/app_colors.dart';

class InputStyles {
  static OutlineInputBorder customBorder({Color? color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: color ?? AppColors.gray,
      ),
    );
  }
}