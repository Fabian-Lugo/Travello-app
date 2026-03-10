import 'package:flutter/material.dart';
import 'package:travell_app/theme/app_colors.dart';

class SlideDot extends StatelessWidget{
 final bool isActive;

  const SlideDot({
    super.key,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 8),
      height: 6,
      width: isActive ? 24 : 12,
      decoration: BoxDecoration(
        color: isActive 
            ? AppColors.primary
            : AppColors.primary.withOpacity(0.3),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}