import 'dart:convert';

class RatingFields {
  static const String id = 'id';
  static const String address = 'address';
  static const String rating = 'rating';
  static const String grassLength = 'grass length';
  static const String bumpiness = 'bumpiness';
  static const String slant = 'slant';
  static const String hardness = 'hardness';
  static const String linesExtra = 'visibility of lines';
  static const String bounciness = 'bounciness';
  static const String indoorOutdoor = 'indoor/outdoor';
  static const String length = 'field length';
  static const String width = 'field width';
  static const String material = 'material';
  static const String turfMaterial = 'turf material';
  static const String extraLines = 'has extra lines';
  static const String direction = 'direction';
  static const String seating = 'seating';
  static const String reservation = 'reservation';
  static const String comment = 'comment';


  static List<String> getRatings() => [id, address, rating, grassLength, bumpiness, slant, hardness, linesExtra, bounciness, indoorOutdoor,
    length, width, material, turfMaterial, extraLines, direction, seating, reservation, comment];

}

class Ratings {
  final int? id;
  final double? rating;
  final double? grassLength;
  final double? bumpiness;
  final double? slant;
  final double? hardness;
  final double? linesExtra;
  final double? bounciness;
  final String? indoorOutdoor;
  final String? length;
  final String? width;
  final String? material;
  final String? turfMaterial;
  final String? extraLines;
  final String? direction;
  final String? seating;
  final String? reservation;
  final String? comment;
  final String? address;

  const Ratings({
    this.id,
    this.rating,
    this.grassLength,
    this.bumpiness,
    this.slant,
    this.hardness,
    this.linesExtra,
    this.bounciness,
    this.indoorOutdoor,
    this.length,
    this.width,
    this.material,
    this.turfMaterial,
    this.extraLines,
    this.direction,
    this.seating,
    this.reservation,
    this.comment,
    this.address,
  });

  static Ratings fromJson(Map<String, dynamic> json) => Ratings(
    id: jsonDecode(json[RatingFields.id]),
    rating: double.tryParse(json[RatingFields.rating] ?? ''),
    grassLength: double.tryParse(json[RatingFields.grassLength] ?? ''),
    bumpiness: double.tryParse(json[RatingFields.bumpiness] ?? ''),
    slant: double.tryParse(json[RatingFields.slant] ?? ''),
    hardness: double.tryParse(json[RatingFields.hardness] ?? ''),
    linesExtra: double.tryParse(json[RatingFields.linesExtra] ?? ''),
    bounciness: double.tryParse(json[RatingFields.bounciness] ?? ''),
    indoorOutdoor: json[RatingFields.indoorOutdoor] ?? '',
    length: json[RatingFields.length] ?? '',
    width: json[RatingFields.width] ?? '',
    material: json[RatingFields.material] ?? '',
    turfMaterial: json[RatingFields.turfMaterial] ?? '',
    extraLines: json[RatingFields.extraLines] ?? '',
    direction: json[RatingFields.direction] ?? '',
    seating: json[RatingFields.seating] ?? '',
    reservation: json[RatingFields.reservation] ?? '',
    comment: json[RatingFields.comment] ?? '',
    address: json[RatingFields.address] ?? '',
  );

  Map<String, dynamic> toJson() => {
    RatingFields.id: id,
    RatingFields.rating: rating,
    RatingFields.grassLength: grassLength,
    RatingFields.bumpiness: bumpiness,
    RatingFields.slant: slant,
    RatingFields.hardness: hardness,
    RatingFields.linesExtra: linesExtra,
    RatingFields.bounciness: bounciness,
    RatingFields.indoorOutdoor: indoorOutdoor,
    RatingFields.length: length,
    RatingFields.width: width,
    RatingFields.material: material,
    RatingFields.turfMaterial: turfMaterial,
    RatingFields.extraLines: extraLines,
    RatingFields.direction: direction,
    RatingFields.seating: seating,
    RatingFields.reservation: reservation,
    RatingFields.comment: comment,
    RatingFields.address: address,
  };
}