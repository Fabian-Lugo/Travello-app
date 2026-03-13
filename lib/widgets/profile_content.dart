import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travell_app/models/user_model.dart';
import 'package:travell_app/services/auth_service.dart';
import 'package:travell_app/services/database_service.dart';
import 'package:travell_app/theme/app_assets.dart';
import 'package:travell_app/theme/app_colors.dart';
import 'package:travell_app/widgets/account_info_style.dart';
import 'package:travell_app/widgets/button_style_default.dart';

class ProfileContent extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String password;
  const ProfileContent({
    super.key,
    required this.name,
    required this.email,
    this.phone = '',
    this.password = '',
  });

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}


class _ProfileContentState extends State<ProfileContent> {
  final DatabaseService _db = DatabaseService();
  bool _createdDocIfMissing = false;

  void signOut() async {
    AuthService.lastLoginPassword = null;
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    }
  }

  void _showAvatarPicker(BuildContext context, String uid) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        decoration: const BoxDecoration(
          color: AppColors.quaternary,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Elige tu avatar',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.tertiary,
              ),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.95,
              ),
              itemCount: AppAssets.avatarList.length,
              itemBuilder: (context, index) {
                final path = AppAssets.avatarList[index];
                return GestureDetector(
                  onTap: () async {
                    Navigator.pop(context);
                    await _db.updateProfileImage(uid, path);
                  },
                  child: ClipOval(
                    child: Image.asset(
                      path,
                      fit: BoxFit.cover,
                      width: 80,
                      height: 80,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('No hay sesión activa. Inicia sesión.')),
      );
    }
    final String uid = user.uid;

    return StreamBuilder<UserModel?>(
      stream: _db.getUserData(uid),
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting){
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasError){
          debugPrint("DEBUG FIREBASE: ${snapshot.error}");
          return const Scaffold(body: Center(child: Text('Error al conectar con el servido')));
        } 

        if (!snapshot.hasData || snapshot.data == null) {
          // Si no existe el documento en Firestore, crearlo con los datos del widget/auth
          if (snapshot.connectionState == ConnectionState.active && !_createdDocIfMissing) {
            _createdDocIfMissing = true;
            final authUser = FirebaseAuth.instance.currentUser;
            if (authUser != null) {
              final fallbackUser = UserModel(
                uid: authUser.uid,
                name: widget.name,
                email: widget.email.isNotEmpty ? widget.email : (authUser.email ?? ''),
                phone: widget.phone.isNotEmpty ? widget.phone : (authUser.phoneNumber ?? ''),
                profileImage: AppAssets.randomAvatar,
              );
              _db.saveUserData(fallbackUser);
            }
          }
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Cargando perfil...'),
                ],
              ),
            ),
          );
        }

        final user = snapshot.data!;
        final avatarPath = user.profileImage.isNotEmpty
            ? user.profileImage
            : AppAssets.boy_2;

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.quaternary,
            actions: [
              IconButton(
                onPressed: () => Navigator.pushNamed(context, '/settings'),
                icon: Icon(CupertinoIcons.settings_solid, color: AppColors.black50),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () => _showAvatarPicker(context, uid),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        ClipOval(
                          child: Image.asset(
                            avatarPath,
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Image.asset(
                              AppAssets.boy_2,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.black50,
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              CupertinoIcons.pencil,
                              color: AppColors.quaternary,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  user.name,
                  style: GoogleFonts.poppins(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                Text(
                  'Tus datos:',
                  style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w300),
                ),
                const SizedBox(height: 35),
                AccountInfoStyle(text: 'Correo', info: user.email, image: AppAssets.mail),
                const SizedBox(height: 15),
                AccountInfoStyle(text: 'Teléfono', info: user.phone, image: AppAssets.mobile),
                const SizedBox(height: 15),
                AccountInfoStyle(
                  key: const Key('profile_password'),
                  text: 'Contraseña',
                  info: (AuthService.lastLoginPassword ?? widget.password).isNotEmpty
                      ? (AuthService.lastLoginPassword ?? widget.password)
                      : '••••••',
                  image: AppAssets.secure,
                  image2: AppAssets.eye1,
                  image3: AppAssets.eye2,
                  secondIcon: true,
                  initialObscureText: false,
                ),
                const SizedBox(height: 30),
                ButtonStyleDefalt(text: 'Cerrar sesión', onTap: signOut, isSecondStyle: true),
              ],
            ),
          ),
        );
      },
    );
  }
}