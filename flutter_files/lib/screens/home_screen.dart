import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:illicit_illustrations_2/screens/image_editor_screen.dart';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ///variable to store [Xfile?] returned by image picker package
  dynamic image;

  ///variable to store image.path type casted to [File]
  late File _image;

  ///allows us to pick image from gallery or camera
  final picker = ImagePicker();

  ///this function to grab the image from camera and pass it onto the image editor screen to be processed
  pickImage() async {
    image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) {
      return null;
    }

    _image = File(image.path);

    _image = File(image.path);
/*
    Uint8List imageBytes = await FlutterImageCompress.compressWithList(
        await image.readAsBytes(),
        quality: 100,
        rotate: 0); */
    Uint8List imageBytes = await image.readAsBytes();
    final tempDir = await getTemporaryDirectory();
    File file = await File('${tempDir.path}/image.png').create();

    file.writeAsBytesSync(imageBytes);
    _image = file;

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageEditor(image: _image),
        ));
  }

  ///this function to grab the image from gallery and pass it onto the image editor screen to be processed
  pickGalleryImage() async {
    image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;

    _image = File(image.path);

    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImageEditor(image: _image),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        /// Image asset for background image
        Image.asset(
          'assets/home_screen_bg.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.fill,
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(80, 40, 80, 60),

            /// Row widget containing buttons for picking image from camera/gallery
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ///Pick image from camera button
                InkWell(
                  onTap: () => pickImage(),
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                        color: Color(0xFF57CACE),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        )),
                    child: Image.asset(
                      'assets/shutter_icon.png',
                    ),
                  ),
                ),

                ///Pick image from gallery button
                InkWell(
                  onTap: () => pickGalleryImage(),
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                        color: Color(0xFFD27AE7),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        )),
                    child: Image.asset(
                      'assets/gallery_icon_2.png',
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
