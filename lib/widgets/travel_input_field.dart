import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travell_app/theme/app_colors.dart';
import 'package:travell_app/utils/input_style.dart';

class TravelInputField extends StatefulWidget {
  final String text;
  final String image;
  final TextEditingController controller;
  final TextInputType type;
  final VoidCallback onChanged;

  const TravelInputField({
    super.key,
    required this.text,
    required this.image,
    required this.controller,
    required this.type,
    required this.onChanged,
  });

  @override
  State<TravelInputField> createState() => _TravelInputFieldState();
}

class _TravelInputFieldState extends State<TravelInputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.type,
      onChanged: (value) {
        widget.onChanged();
      },
      decoration: InputDecoration(
        labelText: widget.text,
        labelStyle: GoogleFonts.poppins(color: AppColors.black50),
        filled: true,
        fillColor: AppColors.gray,
        enabledBorder: InputStyles.customBorder(),
        focusedBorder: InputStyles.customBorder(),
        errorBorder: InputStyles.customBorder(),
        focusedErrorBorder: InputStyles.customBorder(),
        suffixIcon: Align(
          alignment: Alignment.centerRight,
          widthFactor: 1,
          child: Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Image.asset(
              widget.image,
              width: 22,
              height: 22,
              color: AppColors.black50,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
      validator: (value) => 
      (value?.trim().isEmpty ?? true)
      ? 'Completa el campo'
      : null,
    );
  }
}