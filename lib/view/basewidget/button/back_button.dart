import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  final Color color;

  BackButton(this.color);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Icon(Icons.arrow_back_ios, color: color, size: 16),
    );
  }
}
