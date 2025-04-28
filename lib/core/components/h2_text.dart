import 'package:flutter/material.dart';

class H2Text extends StatelessWidget{
  final String text;
  final Color color;
  const H2Text(
    this.text, 
    {
      this.color = Colors.black, super.key
    }
  );

  @override
  Widget build(BuildContext context){
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: 18
      ),
    );
  }
}
