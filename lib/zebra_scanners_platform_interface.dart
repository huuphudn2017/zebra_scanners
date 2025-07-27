import 'dart:typed_data';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'zebra_scanners_method_channel.dart';

typedef DataCallback = void Function(Uint8List bytes);

abstract class ZebraScannersPlatform extends PlatformInterface {
  /// Constructs a ZebraScannersPlatform.
  ZebraScannersPlatform() : super(token: _token);

  static final Object _token = Object();

  static ZebraScannersPlatform _instance = MethodChannelZebraScanners();

  /// The default instance of [ZebraScannersPlatform] to use.
  ///
  /// Defaults to [MethodChannelZebraScanners].
  static ZebraScannersPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ZebraScannersPlatform] when
  /// they register themselves.
  static set instance(ZebraScannersPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  void setDataListenerBarcodeDetector(DataCallback listener);
}
