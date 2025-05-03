import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:reoretier/core/utils/image_picker_manager.dart';

@GenerateMocks([ImagePicker])
import 'image_picker_manager_test.mocks.dart';

void main() {
  late MockImagePicker mockImagePicker;
  late ImagePickerManager imagePickerManager;

  setUp(() {
    mockImagePicker = MockImagePicker();
    imagePickerManager = ImagePickerManager(picker: mockImagePicker);
  });

  group('ImagePickerManager', () {
    test('画像が正常に選択された場合、成功結果を返すこと', () async {
      const mockPath = '/path/to/test_image.jpg';
      final mockXFile = XFile(mockPath);
      when(mockImagePicker.pickImage(source: ImageSource.gallery))
          .thenAnswer((_) async => mockXFile);

      final result = await imagePickerManager.pickImageFromLocal();

      expect(result.isSucceed, true);
      expect(result.value, isA<File>());
      expect(result.value?.path, mockPath);
      expect(result.errorMessage, "");
      
      verify(mockImagePicker.pickImage(source: ImageSource.gallery)).called(1);
    });

    test('ユーザーが画像選択をキャンセルした場合、失敗結果を返すこと', () async {
      when(mockImagePicker.pickImage(source: ImageSource.gallery))
          .thenAnswer((_) async => null);

      final result = await imagePickerManager.pickImageFromLocal();

      expect(result.isSucceed, false);
      expect(result.value, isNull);
      expect(result.errorMessage, "");
      
      verify(mockImagePicker.pickImage(source: ImageSource.gallery)).called(1);
    });

    test('例外が発生した場合、エラーメッセージ付きの失敗結果を返すこと', () async {
      when(mockImagePicker.pickImage(source: ImageSource.gallery))
          .thenThrow(Exception('テストエラー'));

      final result = await imagePickerManager.pickImageFromLocal();

      expect(result.isSucceed, false);
      expect(result.value, isNull);
      expect(result.errorMessage, contains('画像選択エラー'));
      expect(result.errorMessage, contains('テストエラー'));
      
      verify(mockImagePicker.pickImage(source: ImageSource.gallery)).called(1);
    });
  });
}
