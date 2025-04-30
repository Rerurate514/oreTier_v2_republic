import 'package:flutter/material.dart';

import '../../../core/components/h2_text.dart';

class ImpressionForm extends StatefulWidget {
  final TextEditingController textController;
  const ImpressionForm({super.key, required this.textController});

  @override
  State<ImpressionForm> createState() => _ImpressionFormState();
}

class _ImpressionFormState extends State<ImpressionForm> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        const H2Text("感想を入力"),
        SizedBox(height: size.height * 0.02),
        TextField(
          controller: widget.textController,
          maxLines: null,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            labelText: '例：ミステリーがとても面白かった！',
          ),
        )
      ],
    );
  }
}
