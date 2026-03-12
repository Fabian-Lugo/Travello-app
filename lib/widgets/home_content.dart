import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travell_app/theme/app_colors.dart';

class HomeContent extends StatelessWidget {
  final String? name;

  const HomeContent({
    super.key,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: .centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                (name != null && name!.length > 6)
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: .centerLeft,
                            child: Text(
                              'Bienvenido',
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 35),
                            ),
                          ),
                          Text(
                            name!,
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 35, color: AppColors.primary),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          Text(
                            'Bienvenido ',
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 35),
                          ),
                          if (name != null)
                            Text(
                              name!,
                              style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 35, color: AppColors.primary),
                            ),
                        ],
                      ),
                const SizedBox(height: 80),
                Image.asset(
                  'assets/welcome_image.png'
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: .centerLeft,
                  child: Text(
                    'Actualmente, la siguiente parte de "Actividad y Fragmentación del Hogar"\n está en desarrollo. La segunda parte estará disponible próximamente.',
                    style: GoogleFonts.poppins(fontSize: 18),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}