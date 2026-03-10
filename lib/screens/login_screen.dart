import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travell_app/models/user_model.dart';
import 'package:travell_app/theme/app_colors.dart';
import 'package:travell_app/utils/input_style.dart';
import 'package:travell_app/widgets/button_style_default.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controllerText = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final _key = GlobalKey<FormState>();
  String? messageOnScreen;
  String validateMail = '';
  String validatePassword = '';
  bool _obscureText = true;
  bool _rememberMe = false;

  final List<UserModel> users = [
    UserModel(user: 'user1', password: 'test123'),
    UserModel(user: 'user2', password: 'test123'),
    UserModel(user: 'User3', password: 'test123'),
  ];
  

  void _seePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  
  void loginValidate() {
    if (_key.currentState!.validate()) {
        bool? isValidUser = users.any((u) =>
          u.user == _controllerText.text.trim() &&
          u.password == _controllerPassword.text.trim());

        setState(() {
          if (isValidUser) {
            messageOnScreen = null;
            Navigator.pushNamed(context, '/home');
          } else {
            messageOnScreen = 'Credenciales incorrecta';
          }
        });
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
                        fit: .contain,
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
              const SizedBox(height: 100),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 35),
                child: Column(
                  children: [
                    Form(
                      key: _key,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _controllerText,
                            keyboardType: TextInputType.text,
                            onChanged: (value) {
                              if (messageOnScreen != null) {
                                setState(() {
                                  messageOnScreen = null;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Ingresa tu correo',
                              labelStyle: TextStyle(color: AppColors.black50),
                              filled: true,
                              fillColor: AppColors.gray,
                              enabledBorder: InputStyles.customBorder(),
                              focusedBorder: InputStyles.customBorder(),
                              errorBorder: InputStyles.customBorder(),
                              focusedErrorBorder: InputStyles.customBorder(),
                              suffixIcon: Icon(Icons.email_outlined, color: AppColors.black50,)
                            ),
                            validator: (value) => 
                            (value?.trim().isEmpty ?? true)
                            ? 'Ingresa tu correo'
                            : null,
                          ),
                          const SizedBox(height: 30),
                          TextFormField(
                            controller: _controllerPassword,
                            keyboardType: TextInputType.text,
                            onChanged: (value) => setState(() {
                              messageOnScreen = null;
                            }),
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              labelStyle: TextStyle(color: AppColors.black50),
                              filled: true,
                              fillColor: AppColors.gray,
                              enabledBorder: InputStyles.customBorder(),
                              focusedBorder: InputStyles.customBorder(),
                              errorBorder: InputStyles.customBorder(),
                              focusedErrorBorder: InputStyles.customBorder(),
                              suffixIcon: _controllerPassword.text.isNotEmpty
                              ? IconButton(
                                onPressed: _seePassword, 
                                icon: Icon(_obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: AppColors.black50,)
                              )
                              : Icon(Icons.lock_outline_rounded, color: AppColors.black50,)
                            ),
                            validator: (value) => 
                            (value?.trim().isEmpty ?? true)
                            ? 'Ingresa tu contraseña'
                            : null,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    if (messageOnScreen != null)
                      Text(messageOnScreen!,
                        style: GoogleFonts.poppins(color: AppColors.primary, fontSize: 15, fontWeight: FontWeight.w600),
                      ),
                    const SizedBox(height: 20),
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
                          child: Text('Cambiar contraseña',
                            style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.primary),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 115),
                    ButtonStyleDefalt(text: 'Iniciar sesión', onTap: loginValidate),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text('Nuevo miembro?',
                              style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.tertiary)
                            ),
                            const SizedBox(width: 5),
                            GestureDetector(
                              onTap: () => debugPrint('Usuario: Registrarse'),
                              child: Text('Registrate ahora',
                                style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.primary)
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}