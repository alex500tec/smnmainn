import 'package:flutter/material.dart';

class TextoGrisNegrita extends StatelessWidget {
  final String texto;
  final String medida;

  const TextoGrisNegrita({
    super.key,
    required this.texto,
    required this.medida,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          texto,
          style: TextStyle(fontSize: 12.0),
        ),
        Text(
          medida,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
