import 'package:flutter/material.dart';

import '../components/standard_padding.dart';

void showWarnDialog(BuildContext context, String text){
  // ignore: inference_failure_on_function_invocation
  showDialog(
    context: context, 
    builder: (BuildContext context) {
      return SimpleDialog(
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Column(
              children: [
                const Icon(
                  Icons.warning,
                  size: 75,
                  color: Colors.red,
                ),
                const StandardPadding(),
                FittedBox(
                  child: Text(text),
                )
              ],
            )
          ),
        ),
        elevation: 8,
      );
    }
  );
}
