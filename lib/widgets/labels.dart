import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String ruta;
  final String titulo;
  final String subtitulo;
  const Labels(
      {Key? key,
      required this.ruta,
      required this.titulo,
      required this.subtitulo})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(this.titulo,
              style: TextStyle(color: Colors.black54, fontSize: 15)),
          SizedBox(height: 8),
          GestureDetector(
            child: Text(this.subtitulo,
                style: TextStyle(
                    color: Colors.blue[600],
                    fontSize: 20,
                    fontWeight: FontWeight.w600)),
            onTap: () {
              Navigator.pushReplacementNamed(context, this.ruta);
            },
          ),
        ],
      ),
    );
  }
}
