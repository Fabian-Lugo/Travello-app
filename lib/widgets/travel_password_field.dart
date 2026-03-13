import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travell_app/theme/app_assets.dart';
import 'package:travell_app/theme/app_colors.dart';
import 'package:travell_app/utils/input_style.dart';

class TravelPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onChanged;

  const TravelPasswordField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  State<TravelPasswordField> createState() => _TravelPasswordFieldState();
}

class _TravelPasswordFieldState extends State<TravelPasswordField> {
  bool _obscureText = true;

  void _seePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.visiblePassword,
      onChanged: (value) => {
        setState(() {
          widget.onChanged();
        }),
      },
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: 'Contraseña',
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
            child: widget.controller.text.isNotEmpty
            ? GestureDetector(
              onTap: _seePassword,
              child: Image.asset(
                _obscureText ? AppAssets.eye2 : AppAssets.eye1,
                width: 22,
                height: 22,
                color: AppColors.black50,
                fit: BoxFit.contain,
              ),
            )
            : Image.asset(
                AppAssets.secure,
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
      ? 'Ingresa tu contraseña'
      : null,
    );
  }
}