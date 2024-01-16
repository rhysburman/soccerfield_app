import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_making_practice/blocs/models/geometry.dart';
import 'package:form_making_practice/blocs/models/location.dart';
import 'package:form_making_practice/blocs/models/place.dart';
import 'package:form_making_practice/blocs/models/user.dart';
import 'package:form_making_practice/services/data_service.dart';
//import 'package:form_making_practice/blocs/models/place_search.dart';
//import 'package:form_making_practice/services/geocoding_service.dart';
import 'package:form_making_practice/src/screens/rating_screen.dart';
import 'package:form_making_practice/src/screens/reviews_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:form_making_practice/blocs/application_bloc.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _mapController = Completer();
  StreamSubscription? locationSubscription;
  List<Marker> listOfMarkers = <Marker>[];
  var maptype = MapType.normal;
  GoogleMapController? mapController;


  @override
  void initState() {
    final applicationBloc = Provider.of<ApplicationBloc>(context, listen: false);
    
    locationSubscription = applicationBloc.selectedLocation.stream.listen((place) {
      if (place != null) {
        _goToPlace(place);
      }
    });
    super.initState();

    getFields();
  }


  Future<void> getFields() async{
    for (int i = 1; i <= await DataService.getRowCount(); i++){
      final field = await DataService.getById(i);

      final place = Place(
          name: field!.name,
          address: field.address,
          geometry: Geometry (
            location: Location (lat: field.lat, lng: field.lng)
          )
      );
      setState(() {
        listOfMarkers.add(createMarkerFromLocation(place));
      });
      }

    for (int i = 0; i < listOfMarkers.length; i++){
      print ('the markers: ${listOfMarkers[i]}');
    }
  }


  @override
  void dispose() {
    final applicationBloc = Provider.of<ApplicationBloc>(context, listen: false);
    applicationBloc.dispose();
    locationSubscription?.cancel();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<ApplicationBloc>(context);


    return Scaffold(
      body: (applicationBloc.currentLocation == null)?
        const Center(
          child: CircularProgressIndicator(),
        )
      : Stack(
        children: [
          GoogleMap(
            zoomGesturesEnabled: true,
            mapToolbarEnabled: false,
            mapType: maptype,
            myLocationEnabled: true,
            markers: Set<Marker>.of(listOfMarkers),
            initialCameraPosition: CameraPosition(
                target: LatLng(applicationBloc.currentLocation!.latitude,
                    applicationBloc.currentLocation!.longitude),
                zoom: 14),
            onMapCreated: (GoogleMapController controller){
              _mapController.complete(controller);
            },
            //onLongPress: handle,
          ),
          if ((applicationBloc.searchResults != null) && (applicationBloc.searchResults!.length > 0))
            Container(
              padding: const EdgeInsets.only(top: 60),
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(.7),
              ),
            ),
          if ((applicationBloc.searchResults != null) && (applicationBloc.searchResults!.length > 0))
            Container(
              padding: const EdgeInsets.only(top: 60),
              child: ListView.builder(
                itemCount: applicationBloc.searchResults?.length,
                  itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(applicationBloc.searchResults![index].name,
                      style: const TextStyle(color: Colors.black),
                    ),
                    subtitle: Text(applicationBloc.searchResults![index].formattedAddress,
                      style: const TextStyle(color: Colors.blueGrey),
                    ),
                    onTap:() {
                      applicationBloc.setSelectedLocation(applicationBloc.searchResults![index].placeId);
                    }
                  );
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 15, 8, 8),
            child: Container(
              width: 330.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                //borderRadius: BorderRadius.all(Radius.circular(20)),
               ),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search Location',
                  suffixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.fromLTRB(5, 15, 0, 0),
                ),
                onChanged: (value) => applicationBloc.searchPlaces(value),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 5,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.lightBlue),
              ),
              child: const Icon(Icons.content_copy),
              onPressed: () {
                setState((){
                  if (maptype == MapType.normal) {
                    maptype = MapType.hybrid;
                  }
                  else{
                    maptype = MapType.normal;
                  }
                });
              },
            ),
          ),
        ]
      ),
    );
  }

  Future<void> _goToPlace(Place place) async{
    final GoogleMapController controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(place.geometry.location.lat,place.geometry.location.lng), zoom: 16.0
        )
      )
    );
    if (listOfMarkers.contains(createMarkerFromLocation(place)) == false) {
      listOfMarkers.add(createMarkerFromLocation(place));
      await Future.delayed(const Duration(seconds: 2));
      String name = place.name;
      showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Create Location?'),
              content: Text(
                  'There does not seem to be a location at $name, would you like to create one?'),
              actions: <Widget>[
                CupertinoDialogAction(
                  onPressed: () async {
                    final id = await DataService.getRowCount() + 1;

                    final field = Field(
                      id: id,
                      name: name,
                      address: place.address,
                      lng: place.geometry.location.lng,
                      lat: place.geometry.location.lat
                    );
                    await DataService.insert([field.toJson()]);
                    Navigator.pop(context);
                  },
                  child: const Text('Yes'),
                ),
                CupertinoDialogAction(
                  onPressed: () {
                    listOfMarkers.removeLast();
                    Navigator.pop(context);
                  },
                  child: const Text('No'),
                ),
              ]
            );
          }
      );

    }
  }

  Marker createMarkerFromLocation (Place place){
    var markerId = place.name;

    return Marker(
        markerId: MarkerId(markerId),
        draggable: false,
        infoWindow: InfoWindow(
            title: place.name
        ),
        position: LatLng(place.geometry.location.lat, place.geometry.location.lng),
        onTap: () {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                  title: Text(place.name),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => RatingScreen(place: place),));
                      },
                      child: const Text('Rating Screen'),
                    ),
                    CupertinoDialogAction(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ReviewScreen(place: place),));
                      },
                      child: const Text('Review Screen'),
                    ),
                    CupertinoDialogAction(
                        onPressed: () {
                           Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                    )
                  ]
              );
            }
        );
      }
    );
  }
}