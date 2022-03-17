import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_flutter/pages/login_page.dart';
import 'package:chat_flutter/pages/usuarios_pages.dart';

import 'package:chat_flutter/services/auth_services.dart';
import 'package:chat_flutter/services/socket_service.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Text('Autenticando...'),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authServices = Provider.of<AuthServices>(context, listen: false);
    final socketService = Provider.of<SocketService>(context);
    final autenticando = await authServices.isLoggedIn();
    if (autenticando) {
      socketService.connect();
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) => UsuariosPage(),
            transitionDuration: Duration(milliseconds: 20)),
      );
    } else {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) => LoginPage(),
            transitionDuration: Duration(milliseconds: 20)),
      );
    }
  }
}
