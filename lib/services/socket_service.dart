import 'package:chat_flutter/global/environment.dart';
import 'package:chat_flutter/services/auth_services.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  late IO.Socket _socket;
  ServerStatus get serverStatus => this._serverStatus;

  // conectarse con el socket atravez de esta variable
  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;

  void connect() async {
    // Dart client
    // this._socket = IO.io('https://flutter-socketserver22.herokuapp.com/', {
    //   'transports': ['websocket'],
    //   'autoConnect': true
    // });
    final token = await AuthServices.getToken();

    this._socket = IO.io(Environment.socketUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {'x-token': token}
    });
    this._socket.onConnect((_) {
      print('conectado');
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    this._socket.onDisconnect((_) {
      print('desconectado');
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
  }

  void disconnect() {
    this._socket.disconnect();
  }
}
