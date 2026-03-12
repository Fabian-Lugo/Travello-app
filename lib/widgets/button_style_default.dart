import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travell_app/theme/app_colors.dart';

class ButtonStyleDefalt extends StatelessWidget{
  final String text;
  final VoidCallback onTap;
  final bool isSecondStyle;

  const ButtonStyleDefalt({
    super.key,
    required this.text,
    required this.onTap,
    this.isSecondStyle = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: isSecondStyle 
        ? BoxDecoration(
          color: AppColors.quaternary,
          border: Border.all(width: 1, color: AppColors.primary),
          borderRadius: BorderRadius.circular(15), 
        )
        : BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(15), 
        ),
        child: Center(
          child: Text(text,
            style: GoogleFonts.poppins(fontSize: 15, color: isSecondStyle ? AppColors.primary : AppColors.quaternary, fontWeight: isSecondStyle ? FontWeight.w600 : FontWeight.w400),
          ),
        ),
      ),
    );
  }
}

