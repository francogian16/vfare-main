// ignore_for_file: use_function_type_syntax_for_parameters, use_key_in_widget_constructors

import 'package:ai_barcode_platform_interface/ai_barcode_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:my_vfare_app/passenger/qrcodescanner/scanner_plugin.dart';

///
/// PlatformScannerWidget
///
/// Supported android and ios platform read barcode
// ignore: must_be_immutable
class PlatformAiBarcodeScannerWidget extends StatefulWidget {
  ///
  /// Controller.
  late ScannerController _platformScannerController;

  ///
  /// UnsupportedDescription
  String? _unsupportedDescription;

  ///
  /// Constructor.
  PlatformAiBarcodeScannerWidget({
    required ScannerController platformScannerController,
    String? unsupportedDescription,
  }) {
    _platformScannerController = platformScannerController;
    _unsupportedDescription = unsupportedDescription;
  }

  @override
  State<StatefulWidget> createState() {
    return _PlatformScannerWidgetState();
  }
}

///
/// _PlatformScannerWidgetState
class _PlatformScannerWidgetState
    extends State<PlatformAiBarcodeScannerWidget> {
//  StreamSubscription _streamSubscription;

  @override
  void initState() {
    super.initState();
  }

  ///
  /// CreatedListener.
  _widgetCreatedListener() {
    if (widget._platformScannerController._scannerViewCreated != null) {
      widget._platformScannerController._scannerViewCreated!();
    }
  }

  ///
  /// Web result callback
  void _webResultCallback(String result) {
    //if (widget._platformScannerController._scannerResult != null) {
    //callback
    widget._platformScannerController._scannerResult(result);
    //}
  }

  @override
  void dispose() {
    super.dispose();
    //Release
    AiBarcodeScannerPlatform.instance.removeListener(_widgetCreatedListener);
    AiBarcodeScannerPlatform.instance.removeResultCallback(_webResultCallback);
  }

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) {
      if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
        AiBarcodeScannerPlatform.instance = AiBarcodeMobileScannerPlugin();
      }
    }
    //Create
    AiBarcodeScannerPlatform.instance.addListener(_widgetCreatedListener);
    AiBarcodeScannerPlatform.instance.addResultCallback(_webResultCallback);
    AiBarcodeScannerPlatform.instance.unsupportedPlatformDescription =
        widget._unsupportedDescription;
    return AiBarcodeScannerPlatform.instance.buildScannerView(context);
  }
}

///
/// PlatformScannerController
class ScannerController {
  ///
  /// Result
  late Function(String result) _scannerResult;
  Function()? _scannerViewCreated;

  ///
  /// Constructor.
  ScannerController({
    required scannerResult(String result),
    scannerViewCreated,
  }) {
    _scannerResult = scannerResult;
    _scannerViewCreated = scannerViewCreated;
  }

  Function()? get scannerViewCreated => _scannerViewCreated;

  bool get isStartCamera => AiBarcodeScannerPlatform.instance.isStartCamera;
  bool get isStartCameraPreview =>
      AiBarcodeScannerPlatform.instance.isStartCameraPreview;

  bool get isOpenFlash => AiBarcodeScannerPlatform.instance.isOpenFlash;

  ///
  /// Start camera without open QRCode、BarCode scanner,this is just open camera.
  startCamera() {
    AiBarcodeScannerPlatform.instance.startCamera();
  }

  ///
  /// Stop camera.
  stopCamera() async {
    AiBarcodeScannerPlatform.instance.stopCamera();
  }

  ///
  /// Start camera preview with open QRCode、BarCode scanner,this is open code scanner.
  startCameraPreview() async {
    String code = await AiBarcodeScannerPlatform.instance.startCameraPreview();
    _scannerResult(code);
  }

  ///
  /// Stop camera preview.
  stopCameraPreview() async {
    AiBarcodeScannerPlatform.instance.stopCameraPreview();
  }

  ///
  /// Open camera flash.
  openFlash() async {
    AiBarcodeScannerPlatform.instance.openFlash();
  }

  ///
  /// Close camera flash.
  closeFlash() async {
    AiBarcodeScannerPlatform.instance.closeFlash();
  }

  ///
  /// Toggle camera flash.
  toggleFlash() async {
    AiBarcodeScannerPlatform.instance.toggleFlash();
  }
}

///
/// PlatformAiBarcodeCreatorWidget
///
/// Supported android and ios write barcode
// ignore: must_be_immutable


///
/// _PlatformAiBarcodeCreatorState


  

///
/// CreatorController
