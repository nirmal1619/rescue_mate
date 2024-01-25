import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:project_final_year/provider/blue_details_provider.dart';
import 'show_snackbar.dart';

class BluetoothOperation {
  static FlutterBluetoothSerial _bluetooth = FlutterBluetoothSerial.instance;

  static Future<void> turnOnBlue(
      BlueDetailsProvider blueDetailsProvider, BuildContext context) async {
    await _bluetooth.requestEnable();

    await _startBluetooth(blueDetailsProvider, context);
  }

  static void turnOffBlue(BlueDetailsProvider blueDetailsProvider, BuildContext context) async {
    try {
      await _bluetooth.requestDisable();
      blueDetailsProvider.blueState();
      SnackbarClass.showCustomSnackBar(context, "Bluetooth is turned off");
      blueDetailsProvider.connectedHelF(false);
      blueDetailsProvider.connectedBikF(false);
      // Set isBlueOn to false
    } catch (error) {
      print('Error turning off Bluetooth: $error');
    }
  }

  static Future<void> _startBluetooth(
      BlueDetailsProvider blueDetailsProvider, BuildContext context) async {
    var devices = await _bluetooth.getBondedDevices();
    BluetoothDevice device1 =
    devices.firstWhere((device) => device.name == 'helmet device');
    BluetoothDevice device2 =
    devices.firstWhere((device) => device.name == 'Bike Device');
    blueDetailsProvider.device1 = device1;
    blueDetailsProvider.device1 = device2;
    _connectToDevice(
        blueDetailsProvider, device1, 'helmet device', context);
  }

  static Future<void> _connectToDevice(
      BlueDetailsProvider blueDetailsProvider,
      BluetoothDevice device,
      String deviceName,
      BuildContext context,
      ) async {
    try {
      var _connection = await BluetoothConnection.toAddress(device.address);
      SnackbarClass.showCustomSnackBar(context, "Connected to $deviceName");

      if (device.name == 'Bike Device') {
        blueDetailsProvider.blueConnections2(_connection);
        blueDetailsProvider.connectedBikF(true);

        _getStream2(blueDetailsProvider, context);
        _sendDatabike("Start Bike", blueDetailsProvider);
      } else {
        blueDetailsProvider.blueConnections1(_connection);
        blueDetailsProvider.connectedHelF(true);

        // if (!blueDetailsProvider.isEngineStarted) {
        //   _getStream1(blueDetailsProvider, context);
        // }
        _getStream1(blueDetailsProvider, context);
        // sendDataHelmet("App connected with Helmet", blueDetailsProvider);
      }
    } catch (error) {
      print('Error connecting to device: $error');
    }
  }

  static void _getStream1(

      BlueDetailsProvider blueDetailsProvider, BuildContext context
      ) {
    print("_getstream1");
    if (blueDetailsProvider.connection1 != null &&
        blueDetailsProvider.connection1.isConnected) {
      print("connrct conected");
      blueDetailsProvider.connection1.input!.listen(
            (Uint8List data) {
              print(String.fromCharCodes(data));
          String receivedMessage = String.fromCharCodes(data);
          print('Received data: $receivedMessage');


           if(receivedMessage=="Helmet wear"){
             SnackbarClass.showCustomSnackBar(context, receivedMessage);
             blueDetailsProvider.receivedMessF(receivedMessage);
             // blueDetailsProvider.connectedHelF(true);
             blueDetailsProvider.isHelmetWearF(true);
           }
              if(receivedMessage=="Bike connected"){
                SnackbarClass.showCustomSnackBar(context, receivedMessage);
                blueDetailsProvider.receivedMessF(receivedMessage);
                // blueDetailsProvider.connectedHelF(true);
                blueDetailsProvider.connectedBikF(true);
              }


              if(receivedMessage=="Engine started"){
                SnackbarClass.showCustomSnackBar(context, receivedMessage);
                blueDetailsProvider.receivedMessF(receivedMessage);
                blueDetailsProvider.isEngineStartedF(true);
                // blueDetailsProvider.connectedHelF(true);
              }
              if(receivedMessage=="Rider fell"){
                SnackbarClass.showCustomSnackBar(context, receivedMessage);
                blueDetailsProvider.receivedMessF(receivedMessage);
                blueDetailsProvider.isDriverSafeF(false);

              }
          // uncomment after upload linkedin
          // if (receivedMessage == "start bike") {
          //   _connectToDevice(
          //       blueDetailsProvider, blueDetailsProvider.device2, 'Bike Device', context);
          // }
        },
        onError: (error) {
          print('Error receiving data: $error');
        },
        onDone: () {
          print('Connection closed');
        },
      );
    }
  }

  static void _getStream2(
      BlueDetailsProvider blueDetailsProvider, BuildContext context) {
    if (blueDetailsProvider.connection1 != null) {
      blueDetailsProvider.connection1.input!.listen(
            (Uint8List data) {
          String message = String.fromCharCodes(data);
          blueDetailsProvider.receivedMessF(message);
          if (message == "Bike engine Started") {
            blueDetailsProvider.isEngineStartedF(true);
            _connectToDevice(
                blueDetailsProvider, blueDetailsProvider.device1, 'helmet device', context);
          }

          print('Received data: $message');
        },
        onDone: () => print('Connection closed'),
        onError: (error) => print('Error: $error'),
      );
    }
  }

  static void sendDataHelmet(
      String data, BlueDetailsProvider blueDetailsProvider) async {
    if (blueDetailsProvider.connection1 != null &&
        blueDetailsProvider.connection1.isConnected) {
      // await Future.delayed(Duration(seconds: 1));
      String dataToSend = data;

      blueDetailsProvider.connection1.output.add(Uint8List.fromList(dataToSend.codeUnits));
      blueDetailsProvider.sendMessageF(data);
      // await blueDetailsProvider.connection1!.output.allSent;
      // // while (blueDetailsProvider.connection1!.isConnected) {
      // //
      // // }
    }
  }

  static void _sendDatabike(
      String data, BlueDetailsProvider blueDetailsProvider) async {
    if (blueDetailsProvider.connection2 != null &&
        blueDetailsProvider.connection1.isConnected) {
      while (blueDetailsProvider.connection2.isConnected) {
        await Future.delayed(const Duration(seconds: 1));
        String dataToSend = 'Hello bike,message from Flutter!';
        blueDetailsProvider.sendMessageF(dataToSend);
        blueDetailsProvider.connection2.output.add(Uint8List.fromList(dataToSend.codeUnits));
        await blueDetailsProvider.connection2.output.allSent;
      }
    }
  }
}
