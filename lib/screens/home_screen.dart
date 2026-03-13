import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travell_app/services/database_service.dart';
import 'package:travell_app/theme/app_assets.dart';
import 'package:travell_app/theme/app_colors.dart';
import 'package:travell_app/widgets/home_content.dart';
import 'package:travell_app/widgets/profile_content.dart';

class HomeScreen extends StatefulWidget {
  final String? email;
  final String? password;

  const HomeScreen({
    super.key,
    this.email,
    this.password,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final DatabaseService _db = DatabaseService();

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final email = widget.email ?? user?.email ?? '';

    return Scaffold(
      body: user == null
          ? const Center(child: Text('No hay sesión activa'))
          : FutureBuilder(
              future: _db.getUserDataOnce(user.uid),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final name = snapshot.data?.name ?? '';
                return _currentIndex == 0
                    ? HomeContent(name: name.isNotEmpty ? name : null)
                    : ProfileContent(
                        name: name.isNotEmpty ? name : 'Usuario',
                        email: email,
                        password: widget.password ?? '',
                      );
              },
            ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.quaternary,
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              backgroundColor: AppColors.quaternary,
              elevation: 0,
              selectedLabelStyle: GoogleFonts.poppins(fontSize: 12),
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(AppAssets.home, width: 25, color: AppColors.black50),
                  activeIcon: Image.asset(AppAssets.home, width: 25, color: AppColors.primary),
                  label: 'Inicio',
                ),
                BottomNavigationBarItem(
                  icon: Image.asset(AppAssets.profile, width: 25, color: AppColors.black50),
                  activeIcon: Image.asset(AppAssets.profile, width: 25, color: AppColors.primary),
                  label: 'Perfil',
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}