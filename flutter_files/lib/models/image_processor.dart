
import 'dart:typed_data';
import 'dart:io';

import 'package:tflite/tflite.dart';

/// class for functions related to processing image based on tflite model in the assets directory

class ImageProcessor{


  /// Function to load tflite model from assets on to the tflite package
  static loadModel() async {
    //this function loads our model
    await Tflite.loadModel(
      model: 'assets/vangogh.tflite',
    );
  }

  /// Function to process image using the tflite model and return image in Unit8List format
  static Future<Uint8List> processImage(File image) async{

    /// calling function to load tflite model
    await loadModel();

    /// function to run Pix2Pix on image received in parameter of function
    var output = await Tflite.runPix2PixOnImage(
      path: image.path,
      imageMean: 127.5,
      imageStd: 127.5,
      asynch: true,
    );

    return output!;

  }

}