class AppAssets {
  static const String _basePathIcons = 'assets/icons';
  static const String _basePathAvatar = 'assets/avatar';

  //Icons
  static const String arrowLeft = '$_basePathIcons/arrow-left.png';
  static const String arrowRight = '$_basePathIcons/arrow-right.png';
  static const String eye1 = '$_basePathIcons/eye-1.png';
  static const String eye2 = '$_basePathIcons/eye-2.png';
  static const String home = '$_basePathIcons/home.png';
  static const String mail = '$_basePathIcons/mail.png';
  static const String mobile = '$_basePathIcons/mobile.png';
  static const String profile = '$_basePathIcons/profile.png';
  static const String secure = '$_basePathIcons/secure.png';
  static const String trash = '$_basePathIcons/trash.png';
  static const String user = '$_basePathIcons/user.png';

  // Avatars (mismos que en registro y perfil)
  static const String boy_1 = '$_basePathAvatar/boy_1.png';
  static const String boy_2 = '$_basePathAvatar/boy_2.png';
  static const String boy_3 = '$_basePathAvatar/boy_3.png';
  static const String girl_1 = '$_basePathAvatar/girl_1.png';
  static const String girl_2 = '$_basePathAvatar/girl_2.png';
  static const String girl_3 = '$_basePathAvatar/girl_3.png';

  /// Lista de todos los avatares para selector en registro y perfil.
  static const List<String> avatarList = [
    boy_1,
    boy_2,
    boy_3,
    girl_1,
    girl_2,
    girl_3,
  ];

  /// Devuelve un avatar aleatorio de la lista.
  static String get randomAvatar =>
      avatarList[(DateTime.now().millisecondsSinceEpoch % avatarList.length)];
}