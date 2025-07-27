import 'dart:typed_data';

import 'zebra_scanners_platform_interface.dart';

class ZebraScanners {
  static void onBarcodeDetector(void Function(Uint8List data) listener) {
    ZebraScannersPlatform.instance.setDataListenerBarcodeDetector(listener);
  }

  static Future<String?> getPlatformVersion() {
    return ZebraScannersPlatform.instance.getPlatformVersion();
  }
}
