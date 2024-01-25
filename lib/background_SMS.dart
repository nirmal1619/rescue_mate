// ignore: file_names
// import 'dart:js';

import 'package:background_sms/background_sms.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:project_final_year/show_snackbar.dart';

class BackgroundSMS {




  static sendBackgroundSMS(Position _position, Placemark _place,List<String> numbers,BuildContext context) async {

    String message =
        "Help  Help!.......Rider fell at Street: ${_place.street}, Area: ${_place.subLocality}, city: ${_place.locality} , State: ${_place.administrativeArea}, Name: ${_place.name}, Latitude: ${_position.latitude}, Longitude: ${_position.longitude}";

    // print("Sending SMS: $message");

  for(String phoneNumber in numbers){
    await BackgroundSms.sendMessage(
      phoneNumber: phoneNumber,
      message: message,
      simSlot: 2,

    ).then((value) =>SnackbarClass.showCustomSnackBar(context,"SMS Sent Successfully"));
  }


  }
}
