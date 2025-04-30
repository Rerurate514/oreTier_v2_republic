import 'package:flutter/widgets.dart';

class StandardPadding extends StatelessWidget {
  const StandardPadding({super.key});

  @override
  Widget build(BuildContext context){
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        top: size.height * 0.03,
        bottom: size.height * 0.005,
      )
    );
  }
}
