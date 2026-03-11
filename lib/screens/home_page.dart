import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:travell_app/theme/app_colors.dart';

class HomePage extends StatefulWidget {
  final String? name;

  const HomePage({
    super.key,
    this.name
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    final List<Widget> _pages = [
      _buildHomeContent(),
      _buildProfileContent(),
    ];

    return Scaffold(
      body:_currentIndex == 0 
          ? _buildHomeContent() 
          : _buildProfileContent(),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          // CAMBIAR COLOR DE FONDO
          backgroundColor: AppColors.gray,
          elevation: 0,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.black50,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.house),
              activeIcon: Icon(CupertinoIcons.house_fill),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_circle),
              activeIcon: Icon(CupertinoIcons.person_circle_fill),
              label: 'Perfil',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHomeContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: .centerLeft,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('Bienvenido ',
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 35),
                    ),
                    Text('${widget.name}',
                      textAlign: TextAlign.left,
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

  Widget _buildProfileContent() {
    String safeName = widget.name ?? 'User';
    String initial = safeName.substring(0, 1).toUpperCase();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            behavior: .opaque,
            onTap: () => debugPrint('User: Profile Preferences'),
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              elevation: 2,
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center, 
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColors.accent,
                      child: Text(
                        initial, 
                        style: const TextStyle(fontSize: 30, color: AppColors.quaternary, fontWeight: FontWeight.bold)
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min, 
                        children: [
                          Text(
                            'Tu Perfil', 
                            style: GoogleFonts.poppins(
                              fontSize: 18, 
                              fontWeight: FontWeight.w600,
                              color: AppColors.black50,
                            )
                          ),
                          Text(
                            '${widget.name}',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: AppColors.black50,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(CupertinoIcons.chevron_right, color: Colors.grey, size: 18),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}