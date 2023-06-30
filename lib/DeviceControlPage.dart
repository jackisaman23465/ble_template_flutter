import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'CustomCard.dart';
import 'CustomDropDownButton.dart';
import 'UUIDAttribute.dart';

class DeviceControlPage extends StatefulWidget {
  final BluetoothDevice device;

  const DeviceControlPage({
    super.key,
    required this.device,
  });

  @override
  State<DeviceControlPage> createState() => _DeviceControlPageState();
}

class _DeviceControlPageState extends State<DeviceControlPage> {
  late BluetoothDevice device;
  BluetoothService? ledService;
  BluetoothCharacteristic? switchCharacteristic;
  BluetoothCharacteristic? brightnessCharacteristic;
  BluetoothCharacteristic? modeCharacteristic;

  int state = 0;
  int brightness = 0;
  int mode = 0;

  @override
  void initState() {
    super.initState();
    device = widget.device;
  }

  Future<void> discoverServices() async {
    List<BluetoothService> services = await device.discoverServices();
    services.forEach((service) {
      if (service.uuid.toString() == UUIDAttribute.LED_SERVICE_UUID) {
        ledService = service;
        readCharacteristic();
      }
    });
  }

  void readCharacteristic() async {
    var characteristics = ledService!.characteristics;
    for (BluetoothCharacteristic c in characteristics) {
      switch (c.uuid.toString()) {
        case UUIDAttribute.Switch_Characteristic_UUID:
          switchCharacteristic = c;
          List<int> value = await c.read();
          state = value[0];
          setState(() {});
          break;
        case UUIDAttribute.Brightness_Characteristic_UUID:
          brightnessCharacteristic = c;
          List<int> value = await c.read();
          brightness = value[0];
          setState(() {});
          break;
        case UUIDAttribute.Mode_Characteristic_UUID:
          modeCharacteristic = c;
          List<int> value = await c.read();
          mode = value[0];
          setState(() {});
          break;
      }
    }
  }

  bool isWrite = false;

  void writeCharacteristic(BluetoothCharacteristic c, List<int> data) async {
    if (!isWrite) {
      isWrite = true;
      try {
        if(Platform.isAndroid){
          await c.write(data, withoutResponse: true).then((value) => isWrite = false);
        }else if(Platform.isIOS){
          await c.write(data, withoutResponse: false).then((value) => isWrite = false);
        }
      } catch (e) {
        isWrite = false;
      }
    }
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
            onPressed: () async {
              await device.disconnect();
            },
            child: Text(
              "Disconnect",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () async {
              print("connect");
              await device.connect();
              await discoverServices();
            },
            child: Text(
              "Connect",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Led state:",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  state = state == 0x01 ? 0x00 : 0x01;
                  writeCharacteristic(switchCharacteristic!, [state]);
                  setState(() {});
                },
                child: Text(state == 0 ? "on" : "off"),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "Led brightness:",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 5,
            ),
            Slider(
              value: brightness.toDouble(),
              min: 0,
              max: 255,
              divisions: 255,
              onChangeEnd: (value) async {
                brightness = value.toInt();
                print(brightness);
                await Future.delayed(Duration(milliseconds: 10));
                writeCharacteristic(brightnessCharacteristic!, [brightness]);
                setState(() {});
              },
              onChanged: (value) {
                brightness = value.toInt();
                print(brightness);
                writeCharacteristic(brightnessCharacteristic!, [brightness]);
                setState(() {});
              },
            ),
            CustomDropdownButtonFormField(
              title: "Led Mode:",
              value: "Normal",
              options: ["Normal","Breathing"],
              onChanged: (value) {
                if(value == "Normal"){
                  writeCharacteristic(modeCharacteristic!, [0x01]);
                }else if(value == "Breathing"){
                  writeCharacteristic(modeCharacteristic!, [0x02]);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
