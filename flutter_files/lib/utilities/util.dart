import 'dart:typed_data';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';
import 'dart:io';

class Utilities {
  /// Function to share processed image returned by processImage
  static shareImage(Uint8List _img) async {
    final d = await getExternalStorageDirectory();
    final directory = d!.path;
    File imgFile = File('$directory/share_image.png');
    imgFile.writeAsBytes(_img);
    Share.shareFiles(
      ['$directory/share_image.png'],
    );
  }

  ///Function to show toast message
  static showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 1,
    );
  }
}
