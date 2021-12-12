package com.sts.fble;

import android.annotation.SuppressLint;
import android.bluetooth.BluetoothDevice;
import android.os.Bundle;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.github.douglasjunior.bluetoothclassiclibrary.BluetoothClassicService;
import com.github.douglasjunior.bluetoothclassiclibrary.BluetoothConfiguration;
import com.github.douglasjunior.bluetoothclassiclibrary.BluetoothService;
import com.github.douglasjunior.bluetoothclassiclibrary.BluetoothStatus;
import com.sts.fble.Model.DeviceModel;
import com.sts.fble.Model.NativeComModel;
import com.sts.fble.Utils.LogUtil;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.lang.annotation.Native;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import es.dmoral.toasty.Toasty;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {

    private static MethodChannel.Result result;
    private String CHANNEL_SCAN = "com.sts.fble/bluetooth/";

    BluetoothConfiguration config;
    BluetoothService service;
    ArrayList<BluetoothDevice> allDevices = new ArrayList<>();

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        initBluetoothConfig();
    }

    private void initBluetoothConfig(){
        config = new BluetoothConfiguration();
        config.context = getApplicationContext();
        config.bluetoothServiceClass = BluetoothClassicService.class;
        config.bufferSize = 1024;
        config.characterDelimiter = '\n';
        config.deviceName = "FBluetooth";
        config.callListenersInMainThread = true;

        config.uuid = UUID.fromString("00001101-0000-1000-8000-00805f9b34fb"); // Required

        BluetoothService.init(config);

        service = BluetoothService.getDefaultInstance();
    }

    private void connectDevice(String address){
        BluetoothDevice device = null;
        for (BluetoothDevice item : allDevices){
            if (item.getAddress().equals(address)){
                device = item;
                break;
            }
        }

        if (device == null) return;

        service.setOnEventCallback(new BluetoothService.OnBluetoothEventCallback() {
            @Override
            public void onDataRead(byte[] buffer, int length) {
                LogUtil.e("setOnEventCallback");
            }

            @Override
            public void onStatusChange(BluetoothStatus status) {
                LogUtil.e("onStatusChange" + status.name());
            }

            @Override
            public void onDeviceName(String deviceName) {
                LogUtil.e("onDeviceName");
            }

            @Override
            public void onToast(String message) {
                LogUtil.e("onToast");
            }

            @Override
            public void onDataWrite(byte[] buffer) {
                LogUtil.e("onDataWrite");
            }
        });

        service.connect(device); // See also service.disconnect();
    }

    @SuppressLint("MissingPermission")
    private void scanDevice(){

        LogUtil.e("scan device ");

        service.setOnScanCallback(new BluetoothService.OnBluetoothScanCallback() {
            @Override
            public void onDeviceDiscovered(BluetoothDevice device, int rssi) {

                LogUtil.e("onDeviceDiscovered");

                boolean isExist = false;
                for (BluetoothDevice item : allDevices){
                    if (item.getAddress().equals(device.getAddress())){
                        isExist = true;
                        break;
                    }
                }

                if (device.getName() != null){
                    if (!isExist){
                        allDevices.add(device);
                    }
                }
            }

            @Override
            public void onStartScan() {
                LogUtil.e("onStartScan");
                allDevices.clear();
            }

            @Override
            public void onStopScan() {
                LogUtil.e("onStopScan");

                JSONArray jsonArray = new JSONArray();
                for (BluetoothDevice device : allDevices){
                    DeviceModel model = new DeviceModel(device.getName(), device.getAddress());
                    jsonArray.put(model.toJSON());
                }

                MainActivity.result.success(jsonArray.toString());
            }
        });

        service.startScan(); // See also service.stopScan();
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL_SCAN)
                .setMethodCallHandler(new MethodChannel.MethodCallHandler() {
                    @Override
                    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {

                        MainActivity.result = result;

                        NativeComModel nativeComModel;

                        try {
                            JSONObject res = new JSONObject(call.method);
                            nativeComModel = new NativeComModel(res);

                            if (nativeComModel.command.equals("scanDevice")){
                                scanDevice();
                            }else if (nativeComModel.command.equals("connectDevice")){
                                String address = nativeComModel.passValue;
                                connectDevice(address);
                            } else {
                                result.notImplemented();
                            }

                        } catch (JSONException e) {
                            e.printStackTrace();
                        }
                    }
                });
    }

    public void showToast(final String msg){
        Toasty.normal(getBaseContext(), msg, Toast.LENGTH_SHORT).show();
    }
}
