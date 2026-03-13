import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travell_app/theme/app_colors.dart';
import 'package:travell_app/widgets/button_style_default.dart';

class VerificationRegisterScreen extends StatefulWidget{
  final String email;

  const VerificationRegisterScreen({
    super.key,
    required this.email,
  });

  @override
  State<VerificationRegisterScreen> createState() => _VerificationRegisterScreenState();
}

class _VerificationRegisterScreenState extends State<VerificationRegisterScreen> {

  void changePage() {
    Navigator.pushNamed(context, '/login');
  }

  void backPage() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Align(
                    alignment: .centerLeft,
                    child: Text('Casi finalizamos',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 35),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      Align(
                        alignment: .centerLeft,
                        child: Text('¡Casi listo! Revisa tu bandeja de entrada. Te enviamos un correo',
                          textAlign: TextAlign.left,
                          style: GoogleFonts.poppins(fontSize: 18),
                        ),
                      ),
                      Row(
                        children: [
                          Text('de verificación a ',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.poppins(fontSize: 18),
                          ),
                          Text(widget.email,
                            textAlign: TextAlign.left,
                            style: GoogleFonts.poppins(fontSize: 18, color: AppColors.primary),
                            maxLines: 2,
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Align(
                        alignment: .centerLeft,
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '¿Verificaste tu ',
                                style: GoogleFonts.poppins(fontSize: 18),
                              ),
                              TextSpan(
                                text: 'cuenta?',
                                style: GoogleFonts.poppins(fontSize: 18, color: AppColors.primary),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  ButtonStyleDefalt(text: 'Iniciar sesion', onTap: changePage),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.5),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: backPage,
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: const BoxDecoration(
                            color: Color(0xFF222222), 
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white, size: 20),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}