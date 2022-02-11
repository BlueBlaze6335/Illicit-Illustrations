//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<flutter_image_compress/FlutterImageCompressPlugin.h>)
#import <flutter_image_compress/FlutterImageCompressPlugin.h>
#else
@import flutter_image_compress;
#endif

#if __has_include(<fluttertoast/FluttertoastPlugin.h>)
#import <fluttertoast/FluttertoastPlugin.h>
#else
@import fluttertoast;
#endif

#if __has_include(<image_gallery_saver/ImageGallerySaverPlugin.h>)
#import <image_gallery_saver/ImageGallerySaverPlugin.h>
#else
@import image_gallery_saver;
#endif

#if __has_include(<image_picker/FLTImagePickerPlugin.h>)
#import <image_picker/FLTImagePickerPlugin.h>
#else
@import image_picker;
#endif

#if __has_include(<path_provider_ios/FLTPathProviderPlugin.h>)
#import <path_provider_ios/FLTPathProviderPlugin.h>
#else
@import path_provider_ios;
#endif

#if __has_include(<share/FLTSharePlugin.h>)
#import <share/FLTSharePlugin.h>
#else
@import share;
#endif

#if __has_include(<tflite/TflitePlugin.h>)
#import <tflite/TflitePlugin.h>
#else
@import tflite;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FlutterImageCompressPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterImageCompressPlugin"]];
  [FluttertoastPlugin registerWithRegistrar:[registry registrarForPlugin:@"FluttertoastPlugin"]];
  [ImageGallerySaverPlugin registerWithRegistrar:[registry registrarForPlugin:@"ImageGallerySaverPlugin"]];
  [FLTImagePickerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTImagePickerPlugin"]];
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
  [FLTSharePlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTSharePlugin"]];
  [TflitePlugin registerWithRegistrar:[registry registrarForPlugin:@"TflitePlugin"]];
}

@end
