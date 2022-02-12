import 'dart:io';
import 'dart:typed_data';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:illicit_illustrations_2/screens/image_property_editor_screen.dart';
import 'package:path_provider/path_provider.dart';

class ImageCropper extends StatefulWidget {
  /// variable to store File parameter passed from HomeScreen
  final Uint8List imageBytes;

  const ImageCropper({Key? key, required this.imageBytes}) : super(key: key);

  @override
  _ImageCropperState createState() => _ImageCropperState();
}

class _ImageCropperState extends State<ImageCropper> {
  final _cropController = CropController();

  var _isCropping = false;
  var _isCircleUi = false;
  Uint8List? _croppedData;
  var _statusText = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Visibility(
            visible: !_isCropping,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () =>Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_sharp,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        _croppedData == null ? 'Crop View' : "Preview",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          saveImageAndNavigateToPropertyEditor();
                        },
                        icon: const Icon(
                          Icons.done,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Visibility(
                    visible: _croppedData == null,
                    child: Stack(
                      children: [
                        Crop(
                          controller: _cropController,
                          image: widget.imageBytes,
                          onCropped: (croppedData) {
                            setState(() {
                              _croppedData = croppedData;
                              _isCropping = false;
                            });
                          },
                          withCircleUi: _isCircleUi,
                          onStatusChanged: (status) => setState(() {
                            _statusText = <CropStatus, String>{
                                  CropStatus.nothing: 'Crop has no image data',
                                  CropStatus.loading:
                                      'Crop is now loading given image',
                                  CropStatus.ready: 'Crop is now ready!',
                                  CropStatus.cropping:
                                      'Crop is now cropping image',
                                }[status] ??
                                '';
                          }),
                          initialSize: 0.8,
                        ),
                      ],
                    ),
                    replacement: Center(
                      child: _croppedData == null
                          ? const SizedBox.shrink()
                          : Image.memory(
                              _croppedData!,
                              width: MediaQuery.of(context).size.width,
                            ),
                    ),
                  ),
                ),
                if (_croppedData == null)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.crop_7_5,
                                color: Color(0xFF57CACE),
                              ),
                              onPressed: () {
                                _isCircleUi = false;
                                _cropController.aspectRatio = 16 / 4;
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.crop_16_9,
                                color: Color(0xFF57CACE),
                              ),
                              onPressed: () {
                                _isCircleUi = false;
                                _cropController.aspectRatio = 16 / 9;
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.crop_5_4,
                                color: Color(0xFF57CACE),
                              ),
                              onPressed: () {
                                _isCircleUi = false;
                                _cropController.aspectRatio = 4 / 3;
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.crop_square,
                                color: Color(0xFF57CACE),
                              ),
                              onPressed: () {
                                _isCircleUi = false;
                                _cropController
                                  ..withCircleUi = false
                                  ..aspectRatio = 1;
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          color: const Color(0xFFD27AE7),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _isCropping = true;
                              });
                              _isCircleUi
                                  ? _cropController.cropCircle()
                                  : _cropController.crop();
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(child: Text('CROP',style: TextStyle(color: Colors.white,fontSize: 16),)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                const SizedBox(height: 16),
                if (_croppedData == null)
                  Text(
                    _statusText,
                    style: const TextStyle(
                      color: Color(0xFF57CACE),
                    ),
                  ),
                const SizedBox(height: 16),
              ],
            ),
            replacement: const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  void saveImageAndNavigateToPropertyEditor() async {
    final tempDir = await getTemporaryDirectory();
    DateTime now = DateTime.now();
    File file = await File('${tempDir.path}/${now.toString()}.png').create();

    if (_croppedData != null) {
      file.writeAsBytesSync(_croppedData!);
    } else {
      file.writeAsBytesSync(widget.imageBytes);
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImagePropertyEditor(image: file),
      ),
    );
  }
}
