import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TempPage extends StatefulWidget {
  @override
  State<TempPage> createState() => _TempPageState();
}

class _TempPageState extends State<TempPage> {
  static const platform = MethodChannel('com.sts.fble/bluetooth/');
  String scanResult = '';

  Future<void> scanDevice() async {
    String result = '';
    try {
      final res = await platform.invokeMethod('scanDevice');
      result = 'result == ${res}';
    }on PlatformException catch (e) {
      result = 'failed';
    }

    setState(() {
      scanResult = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DeviceList'),
        actions: [
          TextButton(onPressed: () {
            scanDevice();
          }, child: Text('Scan', style: TextStyle(color: Colors.white),))
        ],
      ),
      body: Column(
        children: [
          Text(scanResult)
        ],
      ),
    );
  }
}