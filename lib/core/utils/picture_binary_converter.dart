import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PictureBinaryConverter{
  Future<String> convertBoundaryToImageBase64(RenderRepaintBoundary boundary) async {
    final ui.Image image = await boundary.toImage();
    final ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    final Uint8List imageData = byteData!.buffer.asUint8List();
    final String imageDataBinary = base64Encode(imageData);
    return imageDataBinary;
  }

  ImageProvider convertBase64ToImage(String base64) {
    final Uint8List bytes = base64Decode(base64.split(',').last);
    final ImageProvider imageProvider = Image.memory(bytes).image;
    return imageProvider;
  }
}
