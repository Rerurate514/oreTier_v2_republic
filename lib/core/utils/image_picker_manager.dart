import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'result.dart';

class ImagePickerManager {
  final ImagePicker _picker;

  ImagePickerManager({ImagePicker? picker}) : _picker = picker ?? ImagePicker();
  
  Future<Result<File?>> pickImageFromLocal() async {
    try {
      final XFile? pickerFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickerFile == null) {
        return const Result(value: null, isSucceed: false);
      }
      
      return Result(
        value: File(pickerFile.path), isSucceed: true);
    } catch (e) {
      return Result(
        value: null, 
        isSucceed: false,
        errorMessage: '画像選択エラー: $e'
      );
    }
  }
}
