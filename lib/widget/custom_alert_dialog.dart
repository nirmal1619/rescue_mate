
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'dart:io' if (dart.library.js) 'dart:js';

import 'package:project_final_year/provider/blue_details_provider.dart';
class CustomAlertDialog{

  static Widget bluetoothDialog(BlueDetailsProvider BlueDetail){
    return SizedBox(
      height: 200,
      width: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlueDetail.isBlueOn
                  ? const Text(
                  "Bluetooth Is On",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25
              ))
                  : const Text("Bluetooth Is Off",textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25
                  )),

            ],
          ),
          const SizedBox(height: 10,),
          Card(
            margin: EdgeInsets.zero,
            color: Colors.grey.shade300,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Padding(
                padding: EdgeInsets.zero,
                child: Image.asset("assets/logo/helmetLogo.png",
                  height: 60,
                ),
              ),
              title: Text( BlueDetail.device1Name,style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15
              ),
              ) ,
              subtitle: BlueDetail.isConnectedTohelmet ?
                    const Text("Connected")
                  : const Text("Not Connected"),
              trailing: IconButton(
                onPressed: (){},
                icon: const Icon(CupertinoIcons.pencil_ellipsis_rectangle),
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Card(
            margin: EdgeInsets.zero,
            color: Colors.grey.shade300,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Padding(
                padding: EdgeInsets.zero,
                child: Image.asset("assets/logo/bikeLogo.png",
                  height: 60,
                ),
              ),
              title: Text( BlueDetail.device2Name,style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15
              )) ,
              subtitle: BlueDetail.isConnectedTobike ? const Text("Connected") : const Text("Not Connected"),
              trailing: IconButton(
                onPressed: (){},
                icon: const Icon(CupertinoIcons.pencil_ellipsis_rectangle),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget personDailog(List selectedContacts,Function(String) onDelete)
  {
    return SizedBox(
      height: 200,
      width: 350,
      child: Column(
       children: [
         const Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
                Text("Added Contacts",textAlign: TextAlign.center, style: TextStyle(
                 fontWeight: FontWeight.bold,
                 fontSize: 25
             ),
                ),
           ],
         ),
         Expanded(
           child: ListView.builder(
             shrinkWrap: true,
             itemCount: selectedContacts.length,
             itemBuilder: (context,index)=>
              Card(
               margin: const EdgeInsets.only(top: 10),
               color: Colors.grey.shade300,
               child: ListTile(
                 contentPadding: EdgeInsets.zero,
                 leading: const Padding(
                   padding: EdgeInsets.only(left: 10),
                   child: Icon(
                     CupertinoIcons.person_alt,

                   ),
                 ),
                 title: Text( selectedContacts[index],style: const TextStyle(
                     fontWeight: FontWeight.bold,
                     fontSize: 15
                 ),

                 // ) ,

               ),
                 trailing: IconButton(
                   onPressed: () {
                     onDelete(selectedContacts[index]);
                   },
                   icon: const Icon(CupertinoIcons.delete,),

                 ),

             ),
           ),
           ),
         ),
       ],
      ),
    );
}
  static Widget helmetDialog(BlueDetailsProvider BlueDetail){
    return SizedBox(
      height: 120,
      width: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlueDetail.isConnectedTohelmet
                  ? const Flexible(
                    child: Text("Connected with app",textAlign: TextAlign.center, style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                                )),
                  )
                  : const Flexible(
                    child: Text("Not connected with app",textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    )),
                  ),

            ],
          ),
          const SizedBox(height: 10,),
          Card(
            margin: EdgeInsets.zero,
            color: Colors.grey.shade300,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Padding(
                padding: EdgeInsets.zero,
                child: Image.asset(
                  "assets/logo/helmetLogo.png",

              color:BlueDetail.isConnectedTohelmet ? Colors.redAccent :
              Colors.grey.shade700,
                  height: 80,
              ),
              ),
              title: Text( BlueDetail.device1Name,style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15
              ),
              ) ,
              subtitle: BlueDetail.isHelmetWear ? const Text("Wearing helmet") : const Text("Not wearing helmet"),
              trailing: IconButton(
                onPressed: (){},
                icon: const Icon(CupertinoIcons.pencil_ellipsis_rectangle),
              ),
            ),
          ),

        ],
      ),
    );
  }
  static Widget bikeDialog(BlueDetailsProvider BlueDetail){
    return SizedBox(
      height: 120,
      width: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlueDetail.isConnectedTohelmet
                  ? const Flexible(
                child: Text("Rider is wear helmet",textAlign: TextAlign.center, style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                )),
              )
                  : const Flexible(
                child: Text("Rider is not wear helmet",textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    )),
              ),

            ],
          ),
          const SizedBox(height: 10,),
          Card(
            margin: EdgeInsets.zero,
            color: Colors.grey.shade300,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Padding(
                padding: EdgeInsets.zero,
                child: Image.asset(
                  "assets/logo/bluetoothLogo.png",
                  color:BlueDetail.isConnectedTohelmet ?
                  Colors.redAccent :
                  Colors.grey.shade700,
                  height: 40,
                ),
              ),
              title: Text(
                BlueDetail.device2Name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15
              ),
              ) ,
              subtitle: BlueDetail.isEngineStarted ?
                    const Text("Bike engine is started")
                  : const Text("Bike engine is off"),
              trailing: IconButton(
                onPressed: (){},
                icon: const
                Icon(CupertinoIcons.pencil_ellipsis_rectangle),
              ),
            ),
          ),

        ],
      ),
    );
  }



}