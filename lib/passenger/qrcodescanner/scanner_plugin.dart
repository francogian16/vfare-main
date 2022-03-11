// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ai_barcode_platform_interface/ai_barcode_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:universal_platform/universal_platform.dart';

///
/// AiBarcodeMobileScannerPlugin
class AiBarcodeMobileScannerPlugin extends AiBarcodeScannerPlatform {
  @override
  Widget buildScannerView(BuildContext context) {
    return _cameraView(context);
  }

  /// Barcode reader widget
  ///
  /// Support android and ios platform barcode reader
  Widget _cameraView(BuildContext context) {
    if (UniversalPlatform.isAndroid) {
      return AndroidView(
        viewType: AiBarcodePlatform.viewIdOfScanner,
        onPlatformViewCreated: (int id) {
          onPlatformScannerViewCreated(id);
        },
        creationParams: <String, dynamic>{},
        creationParamsCodec: StandardMessageCodec(),
      );
    } else if (UniversalPlatform.isIOS) {
      return UiKitView(
        viewType: AiBarcodePlatform.viewIdOfScanner,
        onPlatformViewCreated: (int id) {
          onPlatformScannerViewCreated(id);
        },
        creationParams: <String, dynamic>{},
        creationParamsCodec: StandardMessageCodec(),
      );
    } else {
      return Center(
        child: Text(
          unsupportedPlatformDescription,
        ),
      );
    }
  }
}
