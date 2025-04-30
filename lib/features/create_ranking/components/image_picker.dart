import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/image_provider.dart';
import '../providers/is_show_image_provider.dart';

class ImagePicker extends ConsumerStatefulWidget {
  const ImagePicker({super.key});

  @override
  ConsumerState<ImagePicker> createState() => _ImagePickerState();
}

class _ImagePickerState extends ConsumerState<ImagePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.deepPurple,
          width: 4
        )
      ),
      child : InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          ref.watch(isShowImageProvider.notifier).state = !ref.read(isShowImageProvider.notifier).state;
        },
        child: ref.watch(imageProvider.notifier).state != null
        ? Image(image: ref.read(imageProvider.notifier).state!)
        : const Center(
          child: Icon(
            Icons.image_search,
            size: 100,
          ),
        ),
      )
    );
  }
}
