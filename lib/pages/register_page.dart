import 'package:chat_flutter/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_flutter/helpers/mostrar_alerta.dart';
import 'package:chat_flutter/services/auth_services.dart';
import 'package:chat_flutter/widgets/boton_azul.dart';
import 'package:chat_flutter/widgets/custom_input.dart';
import 'package:chat_flutter/widgets/labels.dart';
import 'package:chat_flutter/widgets/logo.dart';

class RegisterPage extends StatelessWidget {
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
                    texto: 'Registro',
                  ),
                  _Form(),
                  Labels(
                      ruta: 'login',
                      titulo: 'Ya tienes cuenta??',
                      subtitulo: 'INGRESA AQUI'),
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
  final nameCtrl = TextEditingController();
  final nombreEmpresaCtrl = TextEditingController();
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
            icon: Icons.perm_identity,
            placeholder: "Nombre",
            keyboardType: TextInputType.name,
            textController: this.nameCtrl,
          ),
          CustomInput(
            icon: Icons.business_outlined,
            placeholder: "Nombre Empresa",
            keyboardType: TextInputType.name,
            textController: this.nombreEmpresaCtrl,
          ),
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
              text: 'CREAR',
              onPressed: () async {
                print(emailCtrl.text);
                print(passCtrl.text);
                print(nameCtrl.text);
                FocusScope.of(context).unfocus();

                final registroOk = await authService.registo(
                  nameCtrl.text.trim(),
                  emailCtrl.text.trim(),
                  passCtrl.text.trim(),
                  nombreEmpresaCtrl.text.trim(),
                );

                if (registroOk == true) {
                  socketService.connect();
                  Navigator.pushReplacementNamed(context, 'usuario');
                } else {
                  mostrarAlerta(context, 'Registro incorrecto', registroOk);
                }
              })
        ],
      ),
    );
  }
}
