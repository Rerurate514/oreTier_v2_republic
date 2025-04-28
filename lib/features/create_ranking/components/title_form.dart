import 'package:flutter/material.dart';

import '../../../core/components/h2_text.dart';

class TitleForm extends StatefulWidget {
  final TextEditingController textController;
  const TitleForm({super.key, required this.textController});

  @override
  State<TitleForm> createState() => _TitleFormState();
}

class _TitleFormState extends State<TitleForm> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        const H2Text("タイトルを入力"),
        SizedBox(height: size.height * 0.02),
        TextField(
          controller: widget.textController,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            labelText: '例：名探偵○○○',
          ),
        )
      ],
    );
  }
}
