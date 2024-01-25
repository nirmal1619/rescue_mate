import 'package:flutter/material.dart';
import 'package:project_final_year/provider/blue_details_provider.dart';
import 'package:project_final_year/screens/SplashScreen.dart';
import 'package:provider/provider.dart';
import 'dart:io' if (dart.library.js) 'dart:js';


void main(){
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const RescueMate());
}

class RescueMate extends StatefulWidget {
  const RescueMate({super.key});

  @override
  State<RescueMate> createState() => _RescueMateState();
}

class _RescueMateState extends State<RescueMate> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
       providers: [
         ChangeNotifierProvider(
             create: (context)=>BlueDetailsProvider(),
         ),
         ChangeNotifierProvider(
           create: (context)=>BlueDetailsProvider(),
         )
       ],
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.grey.shade300,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
