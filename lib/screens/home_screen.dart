import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project_final_year/background_SMS.dart';
import 'package:project_final_year/custom_neumorphism.dart';
import 'package:project_final_year/provider/blue_details_provider.dart';
import 'package:project_final_year/provider/location_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widget/custom_alert_dialog.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Placemark? _place;
  Position? _position;
  bool _isPermissionGranted = false;
  List<String> selectedContacts = [];
  late final SharedPreferences prefs;

  // Permission-related functions
  getPermissionSMS() async {
    PermissionStatus isSMSPermission = await Permission.sms.request();
    if (isSMSPermission == PermissionStatus.granted) {
      setState(() => _isPermissionGranted = true);
    }
  }

  _getContactPermission() async {
    bool permission = await FlutterContactPicker.requestPermission();
    setState(() {});
  }

  // Remaining functions
  void _removeContact(String phoneNumber) {
    setState(() {
      selectedContacts.remove(phoneNumber);
    });

    _updateContactList(selectedContacts);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getPermissionSMS();
    _getContactPermission();
    _getSharedPre();
  }

  driverFell() async {
    if (!_isPermissionGranted) {
      getPermissionSMS();
    }

    if (_place != null && _position != null) {
      if (selectedContacts.isEmpty) {
        await _getContacts();
      }
      await BackgroundSMS.sendBackgroundSMS(
        _position!,
        _place!,
        selectedContacts,
        context,
      );
    } else {
      await _getLocation();
      if (selectedContacts.isEmpty) {
        await _getContacts();
        await BackgroundSMS
            .sendBackgroundSMS(
            _position!, _place!,
            selectedContacts,
            context
        );
      }
    }
    // return Text("SMS sent successfully.");

  }

  _getSharedPre() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs = _prefs;
    });
  }

  _updateContactList(List<String> contact) async {
    await prefs.setStringList("contactList", contact);
  }

  Future<void> _getLocation() async {
    await LocationDetails.getCurrnetLocation();
    if (LocationDetails.place != null) {
      Placemark? result = LocationDetails.place;
      Position? pos = LocationDetails.position;
      if (result != null) {
        setState(() {
          _place = result;
          _position = pos!;
        });
      }
    }
  }

  _getContacts() async {
    List<String>? list = prefs.getStringList('contactList');
    if (list != null) {
      setState(() {
        selectedContacts = list;
      });
    }
  }

  void _showCustomDialog(String type, BlueDetailsProvider BlueDetail) {
    var _widget;

    if (type == "bluetooth") {
      setState(() {
        _widget = CustomAlertDialog.bluetoothDialog(BlueDetail);
      });
    }
    if (type == "person") {
      setState(() {
        _getContacts();
        _widget = CustomAlertDialog.personDailog(selectedContacts, _removeContact);
      });
    }
    if (type == "helmet") {
      setState(() {
        _widget = CustomAlertDialog.helmetDialog(BlueDetail);
      });
    }
    if (type == 'bike') {
      setState(() {
        _widget = CustomAlertDialog.bikeDialog(BlueDetail);
      });
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey.shade200,
          content: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: _widget,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('RescueMate'),
        leading: Image.asset(
          "assets/logo/applogo.png",
          width: 30,
          height: 30,
        ),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.sun_dust),
            onPressed: () {
              // BluetoothOperation.sendDataHelmet("turn led",)
            },
          ),
        ],
      ),
      body: Consumer<BlueDetailsProvider>(
        builder: (context, BlueDetail, child) {
          if (!BlueDetail.isDriverSafe) {
            driverFell();
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30,),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showCustomDialog("bluetooth", BlueDetail);
                      },
                      child: NeumorphismWidget(
                        color: BlueDetail.isBlueOn
                            ? Colors.deepOrangeAccent
                            : Colors.black38,
                        type: "bluetooth",
                        action: "Tap for details",
                        isBlue: true,
                        assetPath: "assets/logo/bluetoothLogo.png",
                        height: 120,
                        icon: CupertinoIcons.pen,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showCustomDialog("person", BlueDetail);
                      },
                      child: const NeumorphismWidget(
                        color: Colors.black,
                        type: "person",
                        action: "Tap for details",
                        isBlue: false,
                        assetPath: "assets/logo/personLogo.png",
                        height: 120,
                        icon: CupertinoIcons.list_number,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showCustomDialog("helmet", BlueDetail);
                      },
                      child: NeumorphismWidget(
                        color: BlueDetail.isHelmetWear
                            ? Colors.deepOrangeAccent
                            : Colors.black38,
                        type: "helmet",
                        action: "Tap for details",
                        isBlue: false,
                        assetPath: "assets/logo/helmetLogo.png",
                        height: 180,
                        icon: CupertinoIcons.link,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showCustomDialog("bike", BlueDetail);
                      },
                      child: NeumorphismWidget(
                        color: BlueDetail.isEngineStarted ? Colors
                            .deepOrangeAccent : Colors.black38,
                        type: "bike",
                        action: "Tap for details",
                        isBlue: false,
                        assetPath: "assets/logo/bikeLogo.png",
                        height: 200,
                        icon: CupertinoIcons.flame,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateColor.resolveWith((
                          states) => Colors.grey.shade200),
                    ),
                    onPressed: () async {
                      if (await FlutterContactPicker.hasPermission()) {
                        final PhoneContact contact = await FlutterContactPicker
                            .pickPhoneContact();
                        if (contact != null) {
                          setState(() {
                            String numericPhoneNumber =
                                contact.phoneNumber?.toString()?.replaceAll(
                                    RegExp(r'[^0-9]'), '') ?? "";
                            selectedContacts.add(numericPhoneNumber);
                          });
                          if (selectedContacts.isNotEmpty) {
                            _updateContactList(selectedContacts);
                          }
                        }
                      }
                    },
                    child: Row(
                      children: [
                        Icon(CupertinoIcons.person_alt, color: Colors.grey
                            .shade700,),
                        const SizedBox(width: 14,),
                        Text("Add Contact", style: TextStyle(
                            color: Colors.grey.shade800,
                            fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                ),

                // Text(BlueDetail.receivedMessage),
              ],
            ),
          );

        }
      ),
    );
  }
}
