import 'package:form_making_practice/blocs/models/place.dart';
import 'package:form_making_practice/blocs/models/place_search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
  final key = 'my_key';

  Future<List<PlaceSearch>?> getAutocomplete(String search) async{
    if (search == ''){
      return null;
    }
    Uri url = Uri.parse('https://maps.googleapis.com/maps/api/place/textsearch/json?query=$search&key=$key');
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => PlaceSearch.fromJson(place)).toList();
  }

  Future<Place> getPlace(String placeId) async{
    Uri url = Uri.parse('https://maps.googleapis.com/maps/api/place/details/json?key=$key&place_id=$placeId');
    var response = await http.get(url);
    var json = convert.jsonDecode(response.body);
    var jsonResult = json['result'] as Map<String, dynamic>;
    return Place.fromJson(jsonResult);
  }

}
