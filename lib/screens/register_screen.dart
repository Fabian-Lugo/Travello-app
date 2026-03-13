import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travell_app/models/user_model.dart';
import 'package:travell_app/services/database_service.dart';
import 'package:travell_app/theme/app_assets.dart';
import 'package:travell_app/theme/app_colors.dart';
import 'package:travell_app/widgets/button_style_default.dart';
import 'package:travell_app/widgets/redirect_text_button.dart';
import 'package:travell_app/widgets/travel_input_field.dart';
import 'package:travell_app/widgets/travel_password_field.dart';

class RegisterScren extends StatefulWidget {
  const RegisterScren({super.key});

  @override
  State<RegisterScren> createState() => _RegisterScrenState();
}

class _RegisterScrenState extends State<RegisterScren> {
  final TextEditingController _controllerTextName = TextEditingController();
  final TextEditingController _controllerTextEmail = TextEditingController();
  final TextEditingController _controllerIntPhone = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final _key = GlobalKey<FormState>();
  String? messageOnScreen;
  bool _checkBox = false;

  final DatabaseService _databaseService = DatabaseService();
  
  void registerValidate() async{
    if(_key.currentState!.validate()) {
      if(_checkBox) {
        try{
          UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: _controllerTextEmail.text.trim(), 
            password: _controllerPassword.text.trim(),
          );

          UserModel newUser = UserModel(
            uid: userCredential.user!.uid,
            name: _controllerTextName.text.trim(),
            email: _controllerTextEmail.text.trim(),
            phone: _controllerIntPhone.text.trim(),
            profileImage: AppAssets.boy_1,
          );

          await _databaseService.saveUserData(newUser);

          if(mounted) {
            print("Navegando a verificación...");
            Navigator.pushNamed(context, '/verification',
              arguments: newUser.email.trim(),
            );
          }

        } on FirebaseAuthException catch(e) {
          setState(() {
            messageOnScreen = e.message;
          });
        }
      } else {
        setState(() {
          messageOnScreen = 'Acepta los terminos';
        });
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
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                    child: Center(
                      child: Image.asset(
                        'assets/image_screen.png',
                        height: size.height * 0.3,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Positioned(
                    top: size.height * 0.260,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Column(
                        children: [
                          Text('Empezemos',
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 40),
                          ),
                          const SizedBox(height: 15),
                          Text('Crea una cuenta gratuita',
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w400, fontSize: 15),
                          ),
                        ],
                      )
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Column(
                  children: [
                    Form(
                      key: _key,
                      child: Column(
                        children: [
                          TravelInputField(
                            text: 'Nombre', 
                            image: AppAssets.user, 
                            controller: _controllerTextName, 
                            type: TextInputType.name,
                            onChanged: () {
                              if (messageOnScreen != null) {
                                setState(() {
                                  messageOnScreen = null;
                                });
                              } 
                            },
                          ),
                          const SizedBox(height: 30),
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
                            },
                          ),
                          const SizedBox(height: 30),
                          TravelInputField(
                            text: 'Número', 
                            image: AppAssets.mobile, 
                            controller: _controllerIntPhone, 
                            type: TextInputType.phone,
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
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: Checkbox(
                                value: _checkBox, 
                                activeColor: AppColors.primary,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                side: const BorderSide(color: AppColors.black50, width: 2),
                                onChanged: (bool? newValue) =>
                                setState(() {
                                  _checkBox = newValue!;
                                })
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Acepto los',
                              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.tertiary),
                            ),
                            const SizedBox(width: 3),
                            GestureDetector(
                              onTap: () => debugPrint('Usuario: Terminos'),
                              behavior: HitTestBehavior.opaque,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 1),
                                child: Text('Terminos',
                                  style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.primary),
                                ),
                              ),
                            ),
                            const SizedBox(width: 3),
                            Text(
                              'y',
                              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.tertiary),
                            ),
                            const SizedBox(width: 3),
                            GestureDetector(
                              onTap: () => debugPrint('Usuario: Condiciones'),
                              behavior: HitTestBehavior.opaque,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 1),
                                child: Text('Condiciones',
                                  style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.primary),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    ButtonStyleDefalt(text: 'Crear cuenta', onTap: registerValidate),
                    const SizedBox(height: 20),
                    RedirectTextButton(
                      text: 'Ya eres miembro?', 
                      textLink: 'Inicia sesión',
                      isReturn: true,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 3),
            ],
          ),
        ),
      ),
    );
  }
}