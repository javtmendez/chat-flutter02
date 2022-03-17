import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_flutter/routes/routes.dart';
import 'package:chat_flutter/services/auth_services.dart';
import 'package:chat_flutter/services/socket_service.dart';

import 'package:chat_flutter/services/chat_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //notificar el provider, esto se hace para utilizar el provider que servira
        //para realizar una conexion.
        ChangeNotifierProvider(create: (_) => AuthServices()),
        ChangeNotifierProvider(create: (_) => SocketService()),
        ChangeNotifierProvider(create: (_) => ChatService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Char App',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}
