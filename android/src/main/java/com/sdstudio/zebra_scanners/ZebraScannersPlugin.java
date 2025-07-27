package com.sdstudio.zebra_scanners;

import android.widget.Button;
import android.widget.TextView;

import androidx.annotation.NonNull;

import com.zebra.barcode.sdk.sms.ConfigurationUpdateEvent;
import com.zebra.scannercontrol.FirmwareUpdateEvent;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class ZebraScannersPlugin implements FlutterPlugin, MethodCallHandler, ScannerAppEngine.IScannerAppEngineDevEventsDelegate {
    private MethodChannel channel;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "zebra_scanners");
        channel.setMethodCallHandler(this);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else {
            result.notImplemented();
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }


    @Override
    public void scannerBarcodeEvent(byte[] barcodeData, int barcodeType, int scannerID) {
//        barcodes.add(new Barcode(barcodeData, barcodeType, scannerID));
        if (channel != null) {
            channel.invokeMethod("onBarcodeDetected", barcodeData);
        }
    }

    @Override
    public void scannerFirmwareUpdateEvent(FirmwareUpdateEvent firmwareUpdateEvent) {

    }

    @Override
    public void scannerImageEvent(byte[] imageData) {

    }

    @Override
    public void scannerVideoEvent(byte[] videoData) {

    }

    @Override
    public void scannerConfigurationUpdateEvent(ConfigurationUpdateEvent configurationUpdateEvent) {

    }
}
