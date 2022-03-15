import 'package:chat_flutter/routes/routes.dart';
import 'package:chat_flutter/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //notificar el provider, esto se hace para utilizar el provider que servira
        //para realizar una conexion.
        ChangeNotifierProvider(
          create: (_) => AuthServices(),
        )
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
