import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:form_making_practice/blocs/models/place.dart';
import 'package:form_making_practice/blocs/models/place_search.dart';
import 'package:form_making_practice/services/geocoding_service.dart';
import 'package:form_making_practice/services/geolocator_service.dart';
import 'package:form_making_practice/services/places__services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ApplicationBloc with ChangeNotifier {
  final geoLocatorService = GeolocatorService();
  final placesService = PlacesService();
  final geoCodingService = GeocodingService();

  //Variables
  Position? currentLocation;
  String? address;
  List<PlaceSearch>? searchResults;
  StreamController<Place> selectedLocation = StreamController<Place>();

  ApplicationBloc() {
    setCurrentLocation();
  }

  setCurrentLocation() async {
    currentLocation = await geoLocatorService.getCurrentLocation();
    notifyListeners();

  }

  searchPlaces(String searchTerm) async {
    searchResults = await placesService.getAutocomplete(searchTerm);
    notifyListeners();
  }

  setSelectedLocation(String placeId) async{
    selectedLocation.add(await placesService.getPlace(placeId));
    searchResults = null;
    notifyListeners();
  }

  getAddress(LatLng _position) async{
    address = geoCodingService.getAddressFromLatLng(_position);
    return address;
  }

  getPlaceId(String _address) async{
    searchResults = await placesService.getAutocomplete(_address);
    return searchResults![0].placeId;
  }


  @override
  void dispose() {
    selectedLocation.close();
    super.dispose();
  }
}