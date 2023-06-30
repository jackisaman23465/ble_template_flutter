import 'package:ble_template_flutter/DeviceControlPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'CustomCard.dart';

class DeviceScanPage extends StatefulWidget {
  const DeviceScanPage({super.key});

  @override
  State<DeviceScanPage> createState() => _DeviceScanPageState();
}

class _DeviceScanPageState extends State<DeviceScanPage> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<ScanResult> scanResults = [];

  @override
  void initState() {
    super.initState();
  }

  void startScan() {
    // Start scanning
    flutterBlue.startScan(timeout: Duration(seconds: 4));

    // Listen to scan results
    var subscription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
        if (r.device.name != "" && !scanResults.contains(r)) {
          scanResults.add(r);
          setState(() {});
        }
      }
    });
  }

  void stopScan() {
    flutterBlue.stopScan();
  }

  void clearUI() {
    scanResults.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("Bluetooth Page"),
        actions: [
          TextButton(
            onPressed: () {
              clearUI();
            },
            child: Text(
              "Clear",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              stopScan();
            },
            child: Text(
              "Stop",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              startScan();
            },
            child: Text(
              "Scan",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: scanResults.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: CustomCard(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(scanResults[index].device.name),
                    Text(scanResults[index].device.id.toString()),
                  ],
                ),
              ],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DeviceControlPage(
                      device: scanResults[index].device,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
