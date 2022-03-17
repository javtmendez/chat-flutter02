import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    required this.online,
    required this.nombre,
    required this.email,
    required this.uid,
    required this.nombreempresa,
  });

  bool online;
  String nombre;
  String email;
  String uid;
  String nombreempresa;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        online: json["online"],
        nombre: json["nombre"],
        email: json["email"],
        uid: json["uid"],
        nombreempresa: json["nombreempresa"],
      );

  Map<String, dynamic> toJson() => {
        "online": online,
        "nombre": nombre,
        "email": email,
        "uid": uid,
        "nombreempresa": nombreempresa,
      };
}
