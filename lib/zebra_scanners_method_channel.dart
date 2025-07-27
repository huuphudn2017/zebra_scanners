import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'zebra_scanners_platform_interface.dart';

/// An implementation of [ZebraScannersPlatform] that uses method channels.
class MethodChannelZebraScanners extends ZebraScannersPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('zebra_scanners');

  DataCallback? _listenerBarcodeDetector;

  MethodChannelZebraScanners() {
    methodChannel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "onBarcodeDetected":
          if (_listenerBarcodeDetector != null) {
            final Uint8List bytes = call.arguments;
            _listenerBarcodeDetector!(bytes);
          }
          break;
      }
    });
  }

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }

  @override
  void setDataListenerBarcodeDetector(DataCallback listener) {
    _listenerBarcodeDetector = listener;
  }
}
