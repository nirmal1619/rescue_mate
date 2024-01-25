import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BlueDetailsProvider with ChangeNotifier {

  bool isBlueOn = false;
  bool isSwitched = false;

  bool isConnectedTohelmet=false;
  bool isConnectedTobike=false;

  late BluetoothDevice device1;
  late BluetoothDevice device2;


  final String device1Name="helmet device";
  final String device2Name='Bike Device';

  late  BluetoothConnection connection1;
  late  BluetoothConnection connection2;

  String receivedMessage = "hello";
  String sendMessage="";
  bool isDataReceived = false;

  bool isEngineStarted=false;
  bool isHelmetWear=false;

  bool isDriverSafe=true;

  void isDriverSafeF(bool value){
    isDriverSafe=value;
  }

  void swicthState(bool value) {
    isSwitched = value;
    notifyListeners();
  }

  void blueState() {
    isBlueOn = !isBlueOn;
    notifyListeners();
  }
  void receivedMessF(String mess){
    receivedMessage=mess;
    notifyListeners();
  }
  void sendMessageF(String message){
    sendMessage=message;
    notifyListeners();
  }

  void connectedHelF(bool value){
    isConnectedTohelmet=value;
    notifyListeners();
  }
  void connectedBikF(bool value){
    isConnectedTobike=value;
    notifyListeners();
  }
  void isEngineStartedF(bool value){
    isEngineStarted=value;
    notifyListeners();
  }
  void isHelmetWearF(bool value){
    isHelmetWear=value;
    notifyListeners();
  }

  void isDatarecF(bool value){
    isDataReceived=value;
    notifyListeners();
  }

  void blueDevicesF(BluetoothDevice d1,BluetoothDevice d2){
    device1=d1;
    device2=d2;
    notifyListeners();
  }
  void blueConnections1(BluetoothConnection connection11){
    connection1=connection11;

    notifyListeners();
  }
  void blueConnections2(BluetoothConnection connection22){

    connection2=connection22;
    notifyListeners();
  }

}