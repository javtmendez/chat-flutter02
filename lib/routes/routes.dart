import 'package:flutter/cupertino.dart';

import 'package:chat_flutter/pages/chat_page.dart';
import 'package:chat_flutter/pages/login_page.dart';
import 'package:chat_flutter/pages/register_page.dart';
import 'package:chat_flutter/pages/usuarios_pages.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'usuario': (_) => UsuariosPage(),
  'chat': (_) => ChatPage(),
  'login': (_) => LoginPage(),
  'loading': (_) => LoginPage(),
  'register': (_) => RegisterPage(),
};
