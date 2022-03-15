import 'package:chat_flutter/services/auth_services.dart';
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
  final usuario = [
    Usuario(
        uid: '1',
        nombre: 'Javier',
        email: 'javtmendez@gmail.com',
        online: true),
    Usuario(
        uid: '1', nombre: 'Jose', email: 'josemendez@gmail.com', online: false),
  ];
  @override
  Widget build(BuildContext context) {
    final authservices = Provider.of<AuthServices>(context);
    final usuario = authservices.usuario;
    return Scaffold(
        appBar: AppBar(
          title: Text(usuario!.nombre.toUpperCase(),
              style: TextStyle(color: Colors.black87)),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(Icons.exit_to_app, color: Colors.black87),
              onPressed: () {
                //TODO:DESCONECTAR EL SOCKET
                Navigator.pushReplacementNamed(context, 'login');
                AuthServices.deleteToken();
              }),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(Icons.check_circle, color: Colors.blue[400]),
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
        itemCount: usuario.length,
        separatorBuilder: (_, i) => Divider(),
        itemBuilder: ((_, i) => _usuarioListTile(usuario[i])));
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
    );
  }

  _cargarUsuarios() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
