package com.sts.fble;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothSocket;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.sts.fble.Model.DeviceModel;
import com.sts.fble.Model.NativeComModel;
import com.sts.fble.Utils.LogUtil;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.annotation.Native;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import es.dmoral.toasty.Toasty;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {

    final  int REQUEST_ENABLE_BT = 101;    
    private static MethodChannel.Result result;
    private String CHANNEL_SCAN = "com.sts.fble/bluetooth/";

    private BluetoothAdapter bluetoothAdapter;
    ArrayList<BluetoothDevice> allDevices = new ArrayList<>();
    
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        // Register for broadcasts when a device is discovered.
        IntentFilter filter = new IntentFilter(BluetoothDevice.ACTION_FOUND);
        registerReceiver(receiver, filter);
        
        initBluetoothConfig();
    }

    // Create a BroadcastReceiver for ACTION_FOUND.
    @SuppressLint("MissingPermission")
    private final BroadcastReceiver receiver = new BroadcastReceiver() {
        public void onReceive(Context context, Intent intent) {
            String action = intent.getAction();
            if (BluetoothDevice.ACTION_FOUND.equals(action)) {

                BluetoothDevice device = intent.getParcelableExtra(BluetoothDevice.EXTRA_DEVICE);

                boolean isAlreadyRegistered = false;
                for (BluetoothDevice item : allDevices) {
                    if (item.getAddress().equals(device.getAddress())){
                        isAlreadyRegistered = true;
                        break;
                    }
                }

                if (!isAlreadyRegistered){
                    if (device.getName() != null && !device.getName().isEmpty()){
                        allDevices.add(device);    
                    }                    
                }
            }
        }
    };
    
    @SuppressLint("MissingPermission")
    private void initBluetoothConfig(){
        
        // check bluetooth is supported
        bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        if (bluetoothAdapter == null){
            LogUtil.e("device doesn't support bluetooth");
        }
        
        // check bluetooth enabled.
        if (!bluetoothAdapter.isEnabled()) {
            Intent enableBtIntent = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
            startActivityForResult(enableBtIntent, REQUEST_ENABLE_BT);
        }
    }

    @SuppressLint("MissingPermission")
    private void connectDevice(String address){
        BluetoothDevice device = null;
        for (BluetoothDevice item : allDevices){
            if (item.getAddress().equals(address)){
                device = item;
                break;
            }
        }

        if (device == null) return;

        IntentFilter filter = new IntentFilter("android.bluetooth.device.action.PAIRING_REQUEST");
        registerReceiver(new PairingRequest(), filter);
    }

    public static class PairingRequest extends BroadcastReceiver {
        public PairingRequest() {
            super();
        }

        @SuppressLint("MissingPermission")
        @Override
        public void onReceive(Context context, Intent intent) {
            if (intent.getAction().equals("android.bluetooth.device.action.PAIRING_REQUEST")) {
                try {
                    BluetoothDevice device = intent.getParcelableExtra(BluetoothDevice.EXTRA_DEVICE);
                    int pin=intent.getIntExtra("android.bluetooth.device.extra.PAIRING_KEY", 0);
                    //the pin in case you need to accept for an specific pin
                    LogUtil.e("PIN ===> " + intent.getIntExtra("android.bluetooth.device.extra.PAIRING_KEY",0));
                    //maybe you look for a name or address
                    LogUtil.e("Bonded ==> " + device.getName());
                    byte[] pinBytes;
                    pinBytes = (""+pin).getBytes("UTF-8");
                    device.setPin(pinBytes);
                    //setPairing confirmation if neeeded
                    device.setPairingConfirmation(true);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }

    @SuppressLint("MissingPermission")
    private void scanDevice(){
        bluetoothAdapter.startDiscovery();

        new Handler().postDelayed(new Runnable() {
            @Override
            public void run() {
                bluetoothAdapter.cancelDiscovery();

                JSONArray jsonArray = new JSONArray();
                for (BluetoothDevice device : allDevices){
                    DeviceModel model = new DeviceModel(device.getName(), device.getAddress());
                    jsonArray.put(model.toJSON());
                }

                MainActivity.result.success(jsonArray.toString());
            }
        }, 10000);
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        unregisterReceiver(receiver);  
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
