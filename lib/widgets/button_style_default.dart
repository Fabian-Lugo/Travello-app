import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travell_app/theme/app_colors.dart';

class ButtonStyleDefalt extends StatelessWidget{
  final String text;
  final VoidCallback onTap;

  const ButtonStyleDefalt({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 55,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(15), 
        ),
        child: Center(
          child: Text(text,
            style: GoogleFonts.poppins(fontSize: 15, color: AppColors.quaternary, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}

