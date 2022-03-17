import 'package:chat_flutter/global/environment.dart';
import 'package:chat_flutter/models/mensajes_response.dart';
import 'package:chat_flutter/models/usuario.dart';
import 'package:chat_flutter/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ChatService with ChangeNotifier {
  Usuario? usuarioPara;

  Future<List<Mensaje>> getChat(String usuarioID) async {
    final uri = Uri.parse('${Environment.apiUrl}/mensajes/$usuarioID');
    final token = await AuthServices.getToken();
    final resp = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'x-token': token!,
    });

    final mensajesResp = mensajesResponseFromJson(resp.body);

    return mensajesResp.mensajes;
  }
}
