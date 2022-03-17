import 'package:chat_flutter/helpers/mostrar_alerta.dart';
import 'package:chat_flutter/services/auth_services.dart';
import 'package:chat_flutter/services/socket_service.dart';
import 'package:chat_flutter/widgets/boton_azul.dart';
import 'package:flutter/material.dart';

import 'package:chat_flutter/widgets/labels.dart';
import 'package:chat_flutter/widgets/custom_input.dart';
import 'package:chat_flutter/widgets/logo.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Logo(
                    stringImagen: 'assets/tag-logo.png',
                    texto: 'Messenger',
                  ),
                  _Form(),
                  Labels(
                    ruta: 'register',
                    titulo: 'No tienes cuenta!',
                    subtitulo: 'CREAR UNA AHORA',
                  ),
                  Text(
                    'Terminos y condiciones de uso',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthServices>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: "Correo electronico",
            keyboardType: TextInputType.emailAddress,
            textController: this.emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: "Contraseña",
            textController: this.passCtrl,
            isPassword: true,
          ),
          // CustomInput(),
          // CustomInput(),
          BotonAzul(
            text: 'INGRESAR',
            onPressed: authService.autenticando
                ? () => {}
                : () async {
                    print(emailCtrl.text);
                    print(passCtrl.text);
                    //creo  mi conectividad con la base de datos a
                    //travez de los auth_services.dart.
                    FocusScope.of(context).unfocus();

                    final loginOk = await authService.login(
                        emailCtrl.text.trim(), passCtrl.text.trim());

                    if (loginOk) {
                      socketService.connect();
                      Navigator.pushReplacementNamed(context, 'usuario');
                    } else {
                      mostrarAlerta(context, 'Login incorrecto',
                          'Revise sus credenciales');
                    }
                  },
          )
        ],
      ),
    );
  }
}
