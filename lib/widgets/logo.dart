import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String stringImagen;
  final String? texto;

  const Logo({
    Key? key,
    required this.stringImagen,
    this.texto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      margin: EdgeInsets.only(top: 50),
      child: Column(
        children: <Widget>[
          Image(image: AssetImage(this.stringImagen)),
          SizedBox(height: 20),
          Text(this.texto!, style: TextStyle(fontSize: 30))
        ],
      ),
    );
  }
}
