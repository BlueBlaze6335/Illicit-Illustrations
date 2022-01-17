import 'dart:typed_data';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:illicit_illustrations_2/models/image_processor.dart';
import 'package:illicit_illustrations_2/utilities/util.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:share/share.dart';

class ImageEditor extends StatefulWidget {
  /// variable to store File parameter passed from HomeScreen
  File image;
  ImageEditor({Key? key, required this.image}) : super(key: key);

  @override
  _ImageEditorState createState() => _ImageEditorState();
}

class _ImageEditorState extends State<ImageEditor> {
  /// variable to change state of page once image has finished processing
  bool imageProcessed = false;

  /// variable to store state of show more options
  bool showMoreOptions = false;

  /// variable to store processed image returned by processImage function
  late Uint8List _output;

  /// variable to store focused index of ScrollSnapList widget
  int _focusedIndex = 0;

  int current = 0;

  /// scroll controller for ScrollSnapList widget
  ScrollController? _controller;

  /// List of assets for artistic style
  List<String> assets = ["", "assets/van_gogh_face.jpg"];

  /// Function to toggle more options view
  void toggleOptions() async {
    setState(() {
      showMoreOptions = !showMoreOptions;
    });
  }

  /// Function to call processImage function of class Image Processor and return precessed image in Uint8List format
  void initialise() async {
    _output = await ImageProcessor.processImage(widget.image);
    setState(() {
      imageProcessed = true;
    });
  }

  /// Widget to return item for ScrollSnapList widget
  Widget _buildListItem(BuildContext context, int index) {
    //horizontal
    return Padding(
      padding: const EdgeInsets.all(8.0),

      /// Widget to shrink widget to 60% of original size when in unfocused position
      child: Transform.scale(
        scale: current == index ? 1 : 0.6,
        child: Container(
            height: 80,
            width: 80,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
            child: assets[index] == ""
                ?

                /// Widget for the initial or no-filter option
                Padding(
                    padding: current == index
                        ? const EdgeInsets.all(5.0)
                        : const EdgeInsets.all(0.0),
                    child: Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.black),
                      child: Padding(
                        padding: current == index
                            ? const EdgeInsets.all(6.0)
                            : const EdgeInsets.all(0.0),
                        child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                :

                /// Widget for the other filters
                Padding(
                    padding: current == index
                        ? const EdgeInsets.all(5.0)
                        : const EdgeInsets.all(0.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                        assets[index],
                      ),
                      radius: 20,
                    ),
                  )),
      ),
    );
  }

  /// initState to trigger initialise function
  @override
  void initState() {
    super.initState();
    initialise();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
                0, MediaQuery.of(context).size.height * 0.1, 0, 0),
            child: imageProcessed
                ? Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        bottom: MediaQuery.of(context).size.height * 0.15,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: GestureDetector(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.75,
                              width: MediaQuery.of(context).size.width * 0.95,
                              child: Stack(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.75,
                                    width: MediaQuery.of(context).size.width *
                                        0.95,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40),
                                      child: _focusedIndex == 1
                                          ?

                                          /// Displaying image returned by tflite model
                                          Image.memory(
                                              _output,
                                              fit: BoxFit.fill,
                                            )
                                          :

                                          /// Displaying initial image
                                          Image.file(
                                              widget.image,
                                              fit: BoxFit.fill,
                                            ),
                                    ),
                                  ),

                                  /// Widget to toggle more options screen on top of the image
                                  InkWell(
                                    onTap: () => toggleOptions(),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.75,
                                      width: MediaQuery.of(context).size.width *
                                          0.95,
                                      color: showMoreOptions
                                          ? Colors.black.withOpacity(0.6)
                                          : Colors.transparent,
                                      child: showMoreOptions
                                          ? Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  /// Widget for save image icon
                                                  InkWell(
                                                    onTap: () async {
                                                      _focusedIndex == 1
                                                          ?

                                                          /// function to save initial image to gallery
                                                          ImageGallerySaver
                                                              .saveFile(widget
                                                                  .image.path)
                                                          :

                                                          /// function to save processed image to gallery
                                                          ImageGallerySaver
                                                              .saveImage(
                                                                  _output!,
                                                                  quality: 100);

                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                              const SnackBar(
                                                        content: Text(
                                                            'Image Saved To Gallery'),
                                                        duration: Duration(
                                                            seconds: 1),
                                                      ));
                                                    },
                                                    child: Container(
                                                      height: 60,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.6)),
                                                      child: const Icon(
                                                        Icons.save_alt,
                                                        color: Colors.white,
                                                        size: 40,
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),

                                                  /// Widget for share image icon
                                                  InkWell(
                                                    onTap: () async {
                                                      _focusedIndex == 0
                                                          ?

                                                          /// function to share initial image
                                                          Share.shareFiles([
                                                              widget.image.path
                                                            ])
                                                          :

                                                          /// function to share processed image
                                                          Utilities.shareImage(_output!);
                                                    },
                                                    child: Container(
                                                      height: 60,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.6)),
                                                      child: const Icon(
                                                        Icons.share,
                                                        color: Colors.white,
                                                        size: 40,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          : Container(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            height: 90,
                            //width: 200,
                            child: ScrollSnapList(
                              listController: _controller,
                              onItemFocus: (pos) {
                                // print(pos);
                                setState(() {
                                  current = pos;
                                  _focusedIndex = pos;
                                });
                              },
                              itemSize: 96,
                              itemBuilder: _buildListItem,
                              itemCount: 2,
                              //reverse: true,
                              //curve: Curves.bounceIn,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                :

                /// Widget to show circular loading animation while image is being processed
                Center(
                    child: SizedBox(
                      height: 480,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
