import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:reoretier/core/utils/picture_binary_converter.dart';

import 'picture_binary_converter_test.mocks.dart';

@GenerateMocks([RenderRepaintBoundary])
void main() {
  late PictureBinaryConverter converter;
  late MockRenderRepaintBoundary mockBoundary;

  setUp(() {
    converter = PictureBinaryConverter();
    mockBoundary = MockRenderRepaintBoundary();
  });

  group('PictureBinaryConverter', () {
    test('convertBoundaryToImageBase64 returns base64 string', () async {
      final mockImage = MockImage();
      final mockByteData = ByteData(10);
      
      when(mockBoundary.toImage()).thenAnswer((_) async => mockImage);
      
      final result = await converter.convertBoundaryToImageBase64(mockBoundary);
      
      expect(result, isA<String>());
      expect(result, equals(base64Encode(mockByteData.buffer.asUint8List())));
      verify(mockBoundary.toImage()).called(1);
    });

    test('convertBase64ToImage returns ImageProvider', () {
      const testBase64 = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8z8BQDwAEhQGAhKmMIQAAAABJRU5ErkJggg==';
      
      final result = converter.convertBase64ToImage(testBase64);
      
      expect(result, isA<ImageProvider>());
      expect(result, isA<MemoryImage>());
    });
  });
}

class MockImage extends Mock implements ui.Image {
  @override
  int get width => 100;
  
  @override
  int get height => 100;
  
  @override
  Future<ByteData?> toByteData({ui.ImageByteFormat format = ui.ImageByteFormat.rawRgba}) {
    return Future.value(ByteData(10));
  }
}
