import 'package:chat_flutter/services/auth_services.dart';
import 'package:chat_flutter/services/chat_service.dart';
import 'package:chat_flutter/services/socket_service.dart';
import 'package:chat_flutter/services/usuarios_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:chat_flutter/models/usuario.dart';

class UsuariosPage extends StatefulWidget {
  @override
  _UsuariosPageState createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final usuarioService = new UsuariosService();
  List<Usuario> usuarios = [];
  // final usuario = [
  //   Usuario(
  //       uid: '1',
  //       nombre: 'Javier',
  //       email: 'javtmendez@gmail.com',
  //       online: true,
  //       nombreempresa: "Empresa 1"),
  //   Usuario(
  //     uid: '1',
  //     nombre: 'Javier',
  //     email: 'javtmendez@gmail.com',
  //     online: true,
  //     nombreempresa: "Empresa 2",
  //   ),
  // ];
  @override
  void initState() {
    this._cargarUsuarios();
    super.initState();
  }

  Widget build(BuildContext context) {
    final authservices = Provider.of<AuthServices>(context);
    final socketService = Provider.of<SocketService>(context);
    final usuario = authservices.usuario;
    return Scaffold(
        appBar: AppBar(
          title: Text(usuario!.nombreempresa.toUpperCase(),
              style: TextStyle(color: Colors.black87)),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.black87),
              onPressed: () {
                //TODO:DESCONECTAR EL SOCKET
                socketService.disconnect();

                //navegar a la pagina de login
                Navigator.pushReplacementNamed(context, 'login');
                AuthServices.deleteToken();
              }),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10),
              child: (socketService.serverStatus == ServerStatus.Online)
                  ? Icon(Icons.check_circle, color: Colors.blue[400])
                  : Icon(Icons.check_circle, color: Colors.red),
              // child: Icon(Icons.offline_bolt, color: Colors.red),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _cargarUsuarios,
          header: WaterDropHeader(
            complete: Icon(Icons.check, color: Colors.blue[400]),
            waterDropColor: Colors.blue,
          ),
          child: _listviewUsuarios(),
        ));
  }

  ListView _listviewUsuarios() {
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        itemCount: usuarios.length,
        separatorBuilder: (_, i) => Divider(),
        itemBuilder: ((_, i) => _usuarioListTile(usuarios[i])));
  }

  ListTile _usuarioListTile(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre),
      subtitle: Text(usuario.email),
      leading: CircleAvatar(
        child: Text(usuario.nombre.substring(0, 2)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: usuario.online ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
      onTap: () {
        // print(usuario.nombreempresa);
        final chatService = Provider.of<ChatService>(context, listen: false);
        chatService.usuarioPara = usuario;
        Navigator.pushNamed(context, 'chat');
        print(usuario.email);
      },
    );
  }

  _cargarUsuarios() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()

    this.usuarios = await usuarioService.getUsuarios();
    setState(() {});
    _refreshController.refreshCompleted();
  }
}
