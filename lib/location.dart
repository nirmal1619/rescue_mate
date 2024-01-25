import 'package:geolocator/geolocator.dart';

class Location{

  static Future<Position> getCurrnetLocation()async{
    //permission
    var position;
    LocationPermission.always;
    LocationPermission locationPermission=await Geolocator.checkPermission();
    if(locationPermission== LocationPermission.denied || locationPermission== LocationPermission.deniedForever){
      //  SnackbarClass.showCustomSnackBar(, content)

      Geolocator.requestPermission();

    }
    else{
      Position currentPosition= await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

      position=currentPosition;
    }

    return position;

  }


}