# Illicit Illustrations

### **To know about the project click [here](https://github.com/BlueBlaze6335/Illicit-Illustrations/blob/main/README.md)**

For help getting started with Flutter, view the online
[documentation](https://flutter.io/).



## **Getting Started**
**Note:** Make sure your Flutter environment is setup.

### Installation

In the command terminal, run the following commands:

    $ git clone https://github.com/BlueBlaze6335/Illicit-Illustrations
    $ cd Illicit_Illustrations/flutter_files/
    $ flutter run

## **Simulate for Android**

    Make sure you have an Android emulator installed and running.
    Run the following command in your terminal.
    $ flutter run


## **Project Structure**

***Note**: The files consisting of the code for the flutter app is present in the **lib** directory under **flutter_files** and the assets used in the project are under **assets** folder under **flutter_files***

***Note**: The packages used in the project is placed under **pubspec.yaml** under **flutter_files***


### Structure for lib directory

### *models*
    - image_processor.dart 
        Consists of functions for processing image received from camera/gallery 

### *screens*
    - splash_screen.dart
        Screen for showing splash screen

    - home_screen.dart
        screen for giving user option to use camera or gallery

    - image_editor_screen.dart
        screen for viewing image and applying filter loaded from tflite model

### Packages used

    - image_picker
    - tflite
    - path_provider: ^2.0.8
    - image_gallery_saver
    - share
    - image
    - scroll_snap_list

**For further assistance mail us at    -  [<img src='https://cdn.jsdelivr.net/npm/simple-icons@3.0.1/icons/gmail.svg' alt='gmail' height='40' align=center>](ayushchoudhury1990@gmail.com)**


<!--# License

```
MIT License

Copyright (c) 2018 Rohan Taneja

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```-->
