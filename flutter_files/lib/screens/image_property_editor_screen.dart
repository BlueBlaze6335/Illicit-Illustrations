import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:illicit_illustrations_2/screens/image_editor_screen.dart';
import 'package:on_image_matrix/on_image_matrix.dart';
import 'package:path_provider/path_provider.dart';

class ImagePropertyEditor extends StatefulWidget {
  /// variable to store File parameter passed from HomeScreen
  final File image;

  const ImagePropertyEditor({Key? key, required this.image}) : super(key: key);

  @override
  _ImagePropertyEditorState createState() => _ImagePropertyEditorState();
}

class _ImagePropertyEditorState extends State<ImagePropertyEditor> {
  final OnImageController _imageController = OnImageController();

  ///Custom filter properties
  double brightnessAndContrast = 0.0;
  double exposure = 0.0;
  double saturation = 1.0;
  double visibility = 1.0;

  ///Index of current filter. -1 denotes custom
  int currentFilter = -1;

  ///List of image filters
  List<ColorFilter> filters = [
    OnImageFilters.normal,
    OnImageFilters.blueSky,
    OnImageFilters.gray,
    OnImageFilters.grayHighBrightness,
    OnImageFilters.grayHighExposure,
    OnImageFilters.grayLowBrightness,
    OnImageFilters.hueRotateWith2,
    OnImageFilters.invert,
    OnImageFilters.kodachrome,
    OnImageFilters.protanomaly,
    OnImageFilters.random,
    OnImageFilters.sepia,
    OnImageFilters.sepium,
    OnImageFilters.technicolor,
    OnImageFilters.vintage,
  ];

  ///List of filter names
  List<String> filtersNames = [
    'normal',
    'blueSky',
    'gray',
    'grayHighBrightness',
    'grayHighExposure',
    'grayLowBrightness',
    'hueRotateWith2',
    'invert',
    'kodachrome',
    'protanomaly',
    'random',
    'sepia',
    'sepium',
    'technicolor',
    'vintage',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.black, //TODO
        title: const Text(
          'Edit View',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              saveImageAndNavigateToEditor();
            },
            icon: const Icon(Icons.done),
          )
        ],
      ),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.6,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: OnImageMatrixWidget.builder(
                    controller: _imageController,
                    colorFilter: currentFilter == -1
                        ? OnImageMatrix.matrix(
                            brightnessAndContrast: brightnessAndContrast,
                            exposure: exposure,
                            saturation: saturation,
                            visibility: visibility,
                          )
                        : filters[currentFilter],
                    imageKey: GlobalKey(),
                    imageFormat: ImageByteFormat.png,
                    child: Image.file(
                      widget.image,
                      alignment: Alignment.topLeft,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            top: MediaQuery.of(context).size.height * 0.6 + 10,

            bottom: 30,
            duration: const Duration(milliseconds: 500),
            curve: Curves.decelerate,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3 + 10,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    getHeading(
                      'Filters',
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: filtersNames.length + 1,
                        itemBuilder: (_, index) {
                          Widget child;

                          if (index == 0) {
                            child = getFilterCard(
                              "Custom",
                              isSelected: currentFilter == index - 1,
                            );
                          } else {
                            child = getFilterCard(
                              filtersNames[index - 1],
                              isSelected: currentFilter == index - 1,
                            );
                          }

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                currentFilter = index - 1;
                              });
                            },
                            child: child,
                          );
                        },
                      ),
                    ),
                    if (currentFilter == -1) ...[
                      const SizedBox(
                        height: 10,
                      ),
                      getHeading(
                        'Brightness&Contrast',
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Slider(
                        max: 5.0,
                        min: -5.0,
                        thumbColor: Colors.white,
                        activeColor: const Color(0xFFD27AE7),
                        inactiveColor: Colors.white,
                        value: brightnessAndContrast,
                        onChanged: (brightnessAndContrast) {
                          if (currentFilter == -1) {
                            setState(() {
                              this.brightnessAndContrast =
                                  brightnessAndContrast;
                            });
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      getHeading(
                        'Exposure',
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Slider(
                        max: 5.0,
                        min: 0.0,
                        thumbColor: Colors.white,
                        activeColor: const Color(0xFFD27AE7),
                        inactiveColor: Colors.white,
                        value: exposure,
                        onChanged: (exposure) {
                          if (currentFilter == -1) {
                            setState(() {
                              this.exposure = exposure;
                            });
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      getHeading(
                        'saturation',
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Slider(
                        max: 5.0,
                        min: 1.0,
                        thumbColor: Colors.white,
                        activeColor: const Color(0xFFD27AE7),
                        inactiveColor: Colors.white,
                        value: saturation,
                        onChanged: (saturation) {
                          if (currentFilter == -1) {
                            setState(() {
                              this.saturation = saturation;
                            });
                          }
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      getHeading(
                        'Visibility',
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Slider(
                        max: 1.0,
                        min: 0.0,
                        thumbColor: Colors.white,
                        activeColor: const Color(0xFFD27AE7),
                        inactiveColor: Colors.white,
                        value: visibility,
                        onChanged: (visibility) {
                          if (currentFilter == -1) {
                            setState(() {
                              this.visibility = visibility;
                            });
                          }
                        },
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Text getHeading(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  resetFilters() {
    setState(() {
      currentFilter = -1;
      brightnessAndContrast = 0.0;
      exposure = 0.0;
      saturation = 1.0;
      visibility = 1.0;
    });
  }

  Widget getFilterCard(String label, {required bool isSelected}) {
    return SizedBox(
      height: 50,
      child: Card(
        color: isSelected ? const Color(0xFFD27AE7) : const Color(0xFF57CACE),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void saveImageAndNavigateToEditor() async {
    _imageController.saveBytes();

    final tempDir = await getTemporaryDirectory();
    DateTime now = DateTime.now();
    File file = await File('${tempDir.path}/${now.toString()}.png').create();

    await Future.delayed(const Duration(seconds: 3));

    if (_imageController.imageBytes == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error processing image"),
        ),
      );
      return;
    } else {
      file.writeAsBytesSync(_imageController.imageBytes ?? []);
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageEditor(image: file),
      ),
    );
  }
}
