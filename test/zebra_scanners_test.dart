import 'package:flutter_test/flutter_test.dart';
import 'package:zebra_scanners/zebra_scanners.dart';
import 'package:zebra_scanners/zebra_scanners_platform_interface.dart';
import 'package:zebra_scanners/zebra_scanners_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockZebraScannersPlatform
    with MockPlatformInterfaceMixin
    implements ZebraScannersPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  void setDataListenerBarcodeDetector(DataCallback listener) {}
}

void main() {
  final ZebraScannersPlatform initialPlatform = ZebraScannersPlatform.instance;

  test('$MethodChannelZebraScanners is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelZebraScanners>());
  });

  test('getPlatformVersion', () async {
    MockZebraScannersPlatform fakePlatform = MockZebraScannersPlatform();
    ZebraScannersPlatform.instance = fakePlatform;

    expect(await ZebraScanners.getPlatformVersion(), '42');
  });
}
