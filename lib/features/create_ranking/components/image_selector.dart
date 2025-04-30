import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:matrix_gesture_detector_pro/matrix_gesture_detector_pro.dart';

import '../../../core/utils/image_picker_manager.dart';
import '../../../core/utils/picture_binary_converter.dart';
import '../../../core/utils/show_warn_dialog.dart';

class ImageSelector extends StatefulWidget {
  final void Function(ImageProvider?, String) closeFragmentCallback;

  const ImageSelector({super.key, required this.closeFragmentCallback});

  @override
  ImageSelectorState createState() => ImageSelectorState();
}

class ImageSelectorState extends State<ImageSelector> {
  final _globalKey = GlobalKey();
  final _converter = PictureBinaryConverter();
  final _imagePicker = ImagePickerManager();

  String _selectedPath = "";
  String _pictureBase64 = "";
  ImageProvider? _editedImage;
  Matrix4 transform = Matrix4.identity();

  void _initValue(){
    setState(() {
      transform = Matrix4.identity();
    });
  }

  Future<void> _setImage() async {
    final File? selectedFile = (await _imagePicker.pickImageFromLocal()).value;
    if(selectedFile == null && mounted) {
      showWarnDialog(
        context, 
        "画像の取得に失敗しました。"
      );
      return;
    }

    setState(() {
      _selectedPath = selectedFile!.path;
    });
  }

  Future<ImageProvider> _captureImage() async {
    final RenderRepaintBoundary boundary = _globalKey.currentContext!.findRenderObject()! as RenderRepaintBoundary;
    _pictureBase64 = await _converter.convertBoundaryToImageBase64(boundary);
    final ImageProvider image = _converter.convertBase64ToImage(_pictureBase64);
    return image;
  }

  Widget _buildPicture(){
    return MatrixGestureDetector(
      onMatrixUpdate: (matrix, translationDeltaMatrix, scaleDeltaMatrix, rotationDeltaMatrix) {
        setState(() {
          transform = matrix;
        });
      },
      child: Transform(
        transform: transform,
        child: _selectedPath != ""
          ? Image.file(File(_selectedPath))
          : const SizedBox(height: 10, width: 10,),
      ),
    );
  }

  Widget _buildButton(IconData iconData, void Function() onPressed){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(
            iconData,
            size: 40,
            color: Colors.deepPurple
          ),
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsetsDirectional.only(top: size.height * 0.1),
      child: Card(
        elevation: 16,
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.1),
          child: Column(
            children: [
              const Text(
                "画像を選択して、編集しよう！。",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                    ),
                    elevation: 16,
                    child: SizedBox(
                      width: 300,
                      height: 300,
                      child: RepaintBoundary(
                          key: _globalKey,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Container(
                              height: 180,
                              width: size.width * 0.9,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: _buildPicture()
                            ),
                          )
                      ),
                    )
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton(
                    Icons.arrow_back, 
                    () {
                      widget.closeFragmentCallback(null, "");
                    }
                  ),
                  _buildButton(
                    Icons.file_download, 
                    () async {
                      _setImage();
                      _initValue();
                    }
                  ),
                  _buildButton(
                    Icons.restart_alt,
                      () => _initValue() 
                    ),
                  _buildButton(
                    Icons.check, 
                    () async {
                      _editedImage = await _captureImage();
                      if(_editedImage == null) return;
                      widget.closeFragmentCallback(_editedImage, _pictureBase64);
                    }
                  ),
                ],
              )
            ],
          )
        ),
      ),
    );
  }
}
