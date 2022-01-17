# Illicit Illustrations

<img src='https://www.tensorflow.org/site-assets/images/project-logos/tensorflow-lite-logo-social.png' alt='gmail' height='120' align="center">

<H></H>

### **To know about the project click [here](https://github.com/BlueBlaze6335/Illicit-Illustrations/blob/main/README.md)**

For help getting started with Tensorflow, view the online
[documentation](https://www.tensorflow.org/).



## **Getting Started**
**Note:** Make sure you know how to use [Google Colab](https://colab.research.google.com/?utm_source=scs-index). All the filters that we will generate will be using tensorflow and keras. 

Dataset for the filters can be taken from Tensorflow datasets [TFDS](https://www.tensorflow.org/datasets/api_docs/python/tfds) , which you can find [here](https://www.tensorflow.org/datasets/catalog/cycle_gan). 

After loading the datasets , you can use them to generate the artistic styles using CycleGAN , and then save the generator that converts an image to the style image in ```.h5``` or ```.keras``` format , and use the [Colab notebook](https://github.com/BlueBlaze6335/Illicit-Illustrations/blob/main/machine%20learning/Convert_to_TFlite.ipynb) to generate the tflite model by uploading the saved model to the storage of the current session. 

Once the tflite file is ready , it can be used to generate the filters in the app !!

### **Installation**

First,  fork the repo , then ,
In the command terminal, run the following commands:


    $ git clone https://github.com/{your username}/llicit-Illustrations
    $ cd Illicit_Illustrations/machine learning/

Then add your notebook and the tflite model. 

Commit your Changes :
    
    $ git commit -m 'Add the Project'

Push to the Branch :

    $  git push --all

Open a Pull Request

## **Project Structure**

***Note***: Each filter will have its own directory where you will save your colab notebook . Also a directory named ***"Assets"*** containing the saved model and the tflite model should be present under the Filter directory. 

### **Structure for machine learning directory**

* [machine learning](https://github.com/BlueBlaze6335/Illicit-Illustrations/tree/main/machine%20learning)
    * [Convert_to_TFlite.ipynb](https://github.com/BlueBlaze6335/Illicit-Illustrations/blob/main/machine%20learning/Convert_to_TFlite.ipynb)
    * [README.md](https://github.com/BlueBlaze6335/Illicit-Illustrations/blob/main/machine%20learning/README.md)

    * [Filter1_VanGogh](https://github.com/BlueBlaze6335/Illicit-Illustrations/tree/main/machine%20learning/Van%20Gogh)
        * [CycleGAN_vangogh.ipynb](https://github.com/BlueBlaze6335/Illicit-Illustrations/blob/main/machine%20learning/Van%20Gogh/CycleGAN_vangogh.ipynb)
        * [Assets](https://github.com/BlueBlaze6335/Illicit-Illustrations/tree/main/machine%20learning/Van%20Gogh/Assets)
            * vangogh.keras
            * vangogh.tflite
    * Filter2
        * CycleGAN_filter2.ipynb
        * Assets
            * filter2.keras/filter2.h5
            * filter2.tflite
    
This is how the directory tree should look like.

## **Contact** 

**Mail us at    -  [<img src='https://cdn.jsdelivr.net/npm/simple-icons@3.0.1/icons/gmail.svg' alt='gmail' height='40' align=center>](mailto:pb2306@ece.jgec.ac.in)**


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
