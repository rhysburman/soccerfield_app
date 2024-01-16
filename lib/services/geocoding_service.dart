import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_geocoding/google_geocoding.dart';

class GeocodingService {

  getAddressFromLatLng(LatLng position) async{
    List<Placemark> placemark = await placemarkFromCoordinates(
        position.latitude, position.longitude);
    Placemark place1 = placemark[0];
    String? locality = place1.locality;
    String? postalCode = place1.postalCode;
    String? country = place1.country;

    String address = "$locality, $postalCode, $country";
    return address;
  }
}
