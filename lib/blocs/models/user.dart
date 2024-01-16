import 'dart:convert';
import 'dart:ffi';

class UserFields {
  static const String id = 'id';
  static const String name = 'name';
  static const String address = 'address';
  static const String lat = 'lat';
  static const String lng = 'lng';

  static List<String> getFields() => [id, name, address, lat, lng];

}

class Field{
  final int? id;
  final String name;
  final String address;
  final double lat;
  final double lng;

  const Field({
    this.id,
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
});

  static Field fromJson(Map<String, dynamic> json) => Field(
    id: jsonDecode(json[UserFields.id]),
    name: json[UserFields.name],
    address: json[UserFields.address],
    lat: jsonDecode(json[UserFields.lat]),
    lng: jsonDecode(json[UserFields.lng]),
  );

  Map<String, dynamic> toJson() => {
    UserFields.id: id,
    UserFields.name: name,
    UserFields.address: address,
    UserFields.lat: lat,
    UserFields.lng: lng,
  };
}