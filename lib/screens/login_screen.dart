import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travell_app/services/auth_service.dart';
import 'package:travell_app/theme/app_assets.dart';
import 'package:travell_app/theme/app_colors.dart';
import 'package:travell_app/widgets/button_style_default.dart';
import 'package:travell_app/widgets/redirect_text_button.dart';
import 'package:travell_app/widgets/travel_input_field.dart';
import 'package:travell_app/widgets/travel_password_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controllerTextEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final _key = GlobalKey<FormState>();
  String? messageOnScreen;
  bool _rememberMe = false;
  
  void loginValidate() async{
    if (_key.currentState!.validate()) {
      try{
        UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _controllerTextEmail.text.trim(),
          password: _controllerPassword.text.trim(),
        );

        if (mounted) {
          final password = _controllerPassword.text.trim();
          AuthService.lastLoginPassword = password;
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/home',
            (route) => false,
            arguments: {
              'email': _controllerTextEmail.text.trim(),
              'password': password,
            },
          );
        }
        debugPrint('$user');
      } on FirebaseAuthException catch (e) {
        if (mounted) {
          setState(() {
            messageOnScreen = e.message;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                    child: Center(
                      child: Image.asset(
                        'assets/image_screen.png',
                        height: size.height * 0.3,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.275,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Column(
                        children: [
                          Text('Bienvenido',
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 40),
                          ),
                          const SizedBox(height: 15),
                          Text('Inicie sesión para acceder a su cuenta',
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 15),
                          ),
                        ],
                      )
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Column(
                  children: [
                    Form(
                      key: _key,
                      child: Column(
                        children: [
                          TravelInputField(
                            text: 'Correo', 
                            image: AppAssets.mail, 
                            controller: _controllerTextEmail, 
                            type: TextInputType.emailAddress,
                            onChanged: () {
                              if (messageOnScreen != null) {
                                setState(() {
                                  messageOnScreen = null;
                                });
                              } 
                            }
                          ),
                          const SizedBox(height: 30),
                          TravelPasswordField(
                            controller: _controllerPassword, 
                            onChanged: () {
                              if (messageOnScreen != null) {
                                setState(() => messageOnScreen = null);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (messageOnScreen != null)
                      Text(messageOnScreen!,
                        style: GoogleFonts.poppins(color: AppColors.primary, fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: Checkbox(
                                value: _rememberMe, 
                                activeColor: AppColors.primary,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                side: const BorderSide(color: AppColors.black50, width: 2),
                                onChanged: (bool? newValue) =>
                                setState(() {
                                  _rememberMe = newValue!;
                                })
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Recordarme',
                              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.tertiary),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => debugPrint('Usuario: Cambiar Contraseña'),
                          behavior: HitTestBehavior.opaque,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            child: Text('Cambiar contraseña',
                              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.primary),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: size.height * 0.12),
                    ButtonStyleDefalt(text: 'Iniciar sesión', onTap: loginValidate),
                    const SizedBox(height: 20),
                    RedirectTextButton(
                      text: 'Nuevo miembro?', 
                      textLink: 'Registrate ahora'
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}