import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/image_provider.dart';
import '../providers/is_show_image_provider.dart';
import 'image_selector.dart';

class ImageSelectorOverlay extends ConsumerStatefulWidget {
  final void Function(String pictureBase64) finishCreatingImageCallback;
  const ImageSelectorOverlay({
    super.key,
    required this.finishCreatingImageCallback
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ImageSelectorOverlayState();
}

class _ImageSelectorOverlayState extends ConsumerState<ImageSelectorOverlay> {

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      duration: const Duration(milliseconds: 300),
      child: ref.watch(isShowImageProvider)
        ? ImageSelector(
            closeFragmentCallback: (ImageProvider? image, String pictureBase64) {
              ref.watch(isShowImageProvider.notifier).state = !ref.watch(isShowImageProvider.notifier).state;
              ref.watch(imageProvider.notifier).state = image;
              
              setState(() {
                widget.finishCreatingImageCallback(pictureBase64);
              });
            },
          )
        : Container(),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}
