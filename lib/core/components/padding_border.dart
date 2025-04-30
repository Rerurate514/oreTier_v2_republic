import 'package:flutter/material.dart';

class PaddingBorder extends StatelessWidget{
  final double widthFactor;
  final double verticalPaddingfactor;

  const PaddingBorder({super.key, this. widthFactor = 0, this.verticalPaddingfactor = 1});

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.02 * verticalPaddingfactor, horizontal: size.width * widthFactor),
      child: const Divider(
        thickness: 2,
        color: Colors.grey,
      ),
    );
  }
}
