import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationDetails {
  static Position? position;
  static Placemark? place;

  static Future<Placemark> getCurrnetLocation() async {
    //permission
    LocationPermission.always;
    LocationPermission locationPermission = await Geolocator.checkPermission();

    if (locationPermission == LocationPermission.denied ||
        locationPermission == LocationPermission.deniedForever) {
      //  SnackbarClass.showCustomSnackBar(, content)
      Geolocator.requestPermission();
    } else {
      Position currentPosition =
      await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
      position = currentPosition;
    }

    List<Placemark> _placemark =
    await placemarkFromCoordinates(position!.latitude, position!.longitude);
    Placemark _currentPlace = await _placemark[0];
    place = _currentPlace;

    return place!;
  }
}
