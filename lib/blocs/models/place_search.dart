class PlaceSearch{
  final String name;
  final String placeId;
  final String formattedAddress;

  PlaceSearch({required this.name, required this.placeId, required this.formattedAddress});

  factory PlaceSearch.fromJson(Map<String, dynamic> parsedJson){
    return PlaceSearch(
      name: parsedJson['name'],
      placeId: parsedJson['place_id'],
      formattedAddress: parsedJson['formatted_address'],
    );
  }
}