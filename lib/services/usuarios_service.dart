import 'package:chat_flutter/global/environment.dart';
import 'package:chat_flutter/models/usuarios_response.dart';
import 'package:chat_flutter/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:chat_flutter/models/usuario.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final token = await AuthServices.getToken();
      final uri = Uri.parse('${Environment.apiUrl}/usuarios');
      final resp = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'x-token': token!,
      });

      final usuariosResponse = usuariosResponseFromJson(resp.body);

      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
