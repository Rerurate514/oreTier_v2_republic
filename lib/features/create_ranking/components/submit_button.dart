import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/components/radius_text_button.dart';

class SubmitButton extends ConsumerStatefulWidget {
  final void Function() createAssesment;
  const SubmitButton({super.key, required this.createAssesment});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends ConsumerState<SubmitButton> {

  @override
  Widget build(BuildContext context) {
    return RadiusTextComponent(
      "これで決定！",
      widthRatio: 0.7,
      textTapped: widget.createAssesment,
    );
  }
}
