import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:form_making_practice/blocs/models/place.dart';
import 'package:form_making_practice/blocs/models/ratings.dart';
import 'package:form_making_practice/services/data_service.dart';

import 'home_screen.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({Key? key, required this.place}) : super(key: key);

  final Place place;

  @override
  _RatingScreenState createState() => _RatingScreenState(place: place);
}

enum indoorOutdoor {indoor, outdoor}
enum Length {short, medium, long}
enum Width {skinny, medium, wide}
enum Material {grass, turf}
enum TurfMaterial {coconutShavings, tireRubber, plasticPellets, sand, rubberCoatedSand}
enum ExtraLines {yes, no}
enum Direction {eastWest, northSouth}
enum Seating {none, small, medium, large, stadium}
enum Reservation {yes, no}

class _RatingScreenState extends State<RatingScreen> {
  _RatingScreenState({required this.place});

  final Place place;
  final comment = TextEditingController();

  double rating = 0;
  double grassLength = 0;
  double bumpiness = 0;
  double slant = 0;
  double hardness = 0;
  double linesExtra = 0;
  double bounciness = 0;
  indoorOutdoor? _indoorOutdoor;
  Length? length;
  Width? width;
  Material? material;
  TurfMaterial? turfMaterial;
  ExtraLines? extraLines;
  Direction? direction;
  Seating? seating;
  Reservation? _reservation;
  String? name;
  String? address;


  @override

  Widget build(BuildContext context) {
    name = place.name;
    address = place.address;


    return Scaffold(
      appBar: AppBar(
        title: Text ('Rating Screen for $name'),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          const Text(
            'Overall Rating',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
          const Padding(padding: EdgeInsets.all(8.0)),
          Text(
              'Rating: $rating',
              style: const TextStyle(
                  fontSize: 20.0
              )
          ),
          const Padding(padding: EdgeInsets.all(8.0)),
          RatingBar.builder(
              minRating: 1,
              maxRating: 5,
              itemSize: 30,
              itemCount: 5,
              itemBuilder: (context, _) =>
              const Icon(Icons.star, color: Colors.black),
              updateOnDrag: true,
              onRatingUpdate: (rating) =>
                  setState(() {
                    this.rating = rating;
                  })
          ),
          const Padding(padding: EdgeInsets.all(8.0)),
          Container(color: Colors.black, height: 2.0,),
          const Padding(padding: EdgeInsets.all(8.0)),
          const Text(
            'Indoor/Outdoor',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
          ListTile(
            title: const Text('Indoor'),
            leading: Radio<indoorOutdoor>(
              value: indoorOutdoor.indoor,
              groupValue: _indoorOutdoor,
              onChanged: (indoorOutdoor? value) {
                setState(() {
                  _indoorOutdoor = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Outdoor'),
            leading: Radio<indoorOutdoor>(
              value: indoorOutdoor.outdoor,
              groupValue: _indoorOutdoor,
              onChanged: (indoorOutdoor? value) {
                setState(() {
                  _indoorOutdoor = value;
                });
              },
            ),
          ),
          const Padding(padding: EdgeInsets.all(8.0)),
          Container(color: Colors.black, height: 2.0,),
          const Padding(padding: EdgeInsets.all(8.0)),
          const Text(
            'Length',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
          ListTile(
            title: const Text('Short (less than 90 yd)'),
            leading: Radio<Length>(
              value: Length.short,
              groupValue: length,
              onChanged: (Length? value) {
                setState(() {
                  length = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Medium (90-110 yd)'),
            leading: Radio<Length>(
              value: Length.medium,
              groupValue: length,
              onChanged: (Length? value) {
                setState(() {
                  length = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Long (greater than 110 yd)'),
            leading: Radio<Length>(
              value: Length.long,
              groupValue: length,
              onChanged: (Length? value) {
                setState(() {
                  length = value;
                });
              },
            ),
          ),
          const Padding(padding: EdgeInsets.all(8.0)),
          Container(color: Colors.black, height: 2.0,),
          const Padding(padding: EdgeInsets.all(8.0)),
          const Text(
            'Width',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
          const Text(
            'Note: Width is judged by distance from outside the box to the touchline',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10.0,
            ),
          ),
          ListTile(
            title: const Text('Skinny (5-11 yd)'),
            leading: Radio<Width>(
              value: Width.skinny,
              groupValue: width,
              onChanged: (Width? value) {
                setState(() {
                  width = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Medium (11-18 yd)'),
            leading: Radio<Width>(
              value: Width.medium,
              groupValue: width,
              onChanged: (Width? value) {
                setState(() {
                  width = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Wide (18-24 yd)'),
            leading: Radio<Width>(
              value: Width.wide,
              groupValue: width,
              onChanged: (Width? value) {
                setState(() {
                  width = value;
                });
              },
            ),
          ),
          const Padding(padding: EdgeInsets.all(8.0)),
          Container(color: Colors.black, height: 2.0,),
          const Padding(padding: EdgeInsets.all(8.0)),
          const Text(
            'Grass/Turf',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
          ListTile(
            title: const Text('Grass'),
            leading: Radio<Material>(
              value: Material.grass,
              groupValue: material,
              onChanged: (Material? value) {
                setState(() {
                  material = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Turf'),
            leading: Radio<Material>(
              value: Material.turf,
              groupValue: material,
              onChanged: (Material? value) {
                setState(() {
                  material = value;
                });
              },
            ),
          ),
          const Padding(padding: EdgeInsets.all(8.0)),
          Container(color: Colors.black, height: 2.0,),
          const Padding(padding: EdgeInsets.all(8.0)),
          if (material == Material.grass)
            const Text(
              'Grass Length',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
          if (material == Material.grass)
            const Padding(padding: EdgeInsets.all(8.0)),
          if (material == Material.grass)
            Text(
                'Rating: $grassLength',
                style: const TextStyle(
                    fontSize: 20.0
                )
            ),
          if (material == Material.grass)
            const Padding(padding: EdgeInsets.all(8.0)),
          if (material == Material.grass)
            RatingBar.builder(
                minRating: 1,
                maxRating: 10,
                itemSize: 30,
                itemCount: 5,
                itemBuilder: (context, _) =>
                const Icon(Icons.star, color: Colors.black),
                updateOnDrag: true,
                onRatingUpdate: (rating) =>
                    setState(() {
                      grassLength = rating;
                    })
            ),
          if (material == Material.grass)
            const Padding(padding: EdgeInsets.all(8.0)),
          if (material == Material.grass)
            Container(color: Colors.black, height: 2.0,),
          if (material == Material.grass)
            const Padding(padding: EdgeInsets.all(8.0)),
          if (material == Material.grass)
            const Text(
              'Bumpiness',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
          if (material == Material.grass)
            const Padding(padding: EdgeInsets.all(8.0)),
          if (material == Material.grass)
            Text(
                'Rating: $bumpiness',
                style: const TextStyle(
                    fontSize: 20.0
                )
            ),
          if (material == Material.grass)
            const Padding(padding: EdgeInsets.all(8.0)),
          if (material == Material.grass)
            RatingBar.builder(
                minRating: 1,
                maxRating: 10,
                itemSize: 30,
                itemCount: 5,
                itemBuilder: (context, _) =>
                const Icon(Icons.star, color: Colors.black),
                updateOnDrag: true,
                onRatingUpdate: (rating) =>
                    setState(() {
                      bumpiness = rating;
                    })
            ),
          if (material == Material.grass)
            const Padding(padding: EdgeInsets.all(8.0)),
          if (material == Material.grass)
            Container(color: Colors.black, height: 2.0,),
          if (material == Material.grass)
            const Padding(padding: EdgeInsets.all(8.0)),
          if (material == Material.grass)
            const Text(
              'Slant',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
          if (material == Material.grass)
            const Padding(padding: EdgeInsets.all(8.0)),
          if (material == Material.grass)
            Text(
                'Rating: $slant',
                style: const TextStyle(
                    fontSize: 20.0
                )
            ),
          if (material == Material.grass)
            const Padding(padding: EdgeInsets.all(8.0)),
          if (material == Material.grass)
            RatingBar.builder(
                minRating: 1,
                maxRating: 10,
                itemSize: 30,
                itemCount: 5,
                itemBuilder: (context, _) =>
                const Icon(Icons.star, color: Colors.black),
                updateOnDrag: true,
                onRatingUpdate: (rating) =>
                    setState(() {
                      slant = rating;
                    })
            ),
          if (material == Material.grass)
            const Padding(padding: EdgeInsets.all(8.0)),
          if (material == Material.grass)
            Container(color: Colors.black, height: 2.0,),
          if (material == Material.grass)
            const Padding(padding: EdgeInsets.all(8.0)),
          if (material == Material.grass)
            const Text(
              'Hardness of the Ground',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
          if (material == Material.grass)
            const Padding(padding: EdgeInsets.all(8.0)),
          if (material == Material.grass)
            Text(
                'Rating: $hardness',
                style: const TextStyle(
                    fontSize: 20.0
                )
            ),
          if (material == Material.grass)
            const Padding(padding: EdgeInsets.all(8.0)),
          if (material == Material.grass)
            RatingBar.builder(
                minRating: 1,
                maxRating: 10,
                itemSize: 30,
                itemCount: 5,
                itemBuilder: (context, _) =>
                const Icon(Icons.star, color: Colors.black),
                updateOnDrag: true,
                onRatingUpdate: (rating) =>
                    setState(() {
                      hardness = rating;
                    })
            ),
          if (material == Material.grass)
            const Padding(padding: EdgeInsets.all(8.0)),
          if (material == Material.grass)
            Container(color: Colors.black, height: 2.0,),
          if (material == Material.grass)
            const Padding(padding: EdgeInsets.all(8.0)),
          if (material == Material.turf)
            const Text(
              'Material of the Turf',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
          if (material == Material.turf)
            ListTile(
              title: const Text('Coconut Shavings'),
              leading: Radio<TurfMaterial>(
                value: TurfMaterial.coconutShavings,
                groupValue: turfMaterial,
                onChanged: (TurfMaterial? value) {
                  setState(() {
                    turfMaterial = value;
                  });
                },
              ),
            ),
          if (material == Material.turf)
            ListTile(
              title: const Text('Tire Rubber'),
              leading: Radio<TurfMaterial>(
                value: TurfMaterial.tireRubber,
                groupValue: turfMaterial,
                onChanged: (TurfMaterial? value) {
                  setState(() {
                    turfMaterial = value;
                  });
                },
              ),
            ),
          if (material == Material.turf)
            ListTile(
              title: const Text('Plastic Pellets'),
              leading: Radio<TurfMaterial>(
                value: TurfMaterial.plasticPellets,
                groupValue: turfMaterial,
                onChanged: (TurfMaterial? value) {
                  setState(() {
                    turfMaterial = value;
                  });
                },
              ),
            ),
          if (material == Material.turf)
            ListTile(
              title: const Text('Sand'),
              leading: Radio<TurfMaterial>(
                value: TurfMaterial.sand,
                groupValue: turfMaterial,
                onChanged: (TurfMaterial? value) {
                  setState(() {
                    turfMaterial = value;
                  });
                },
              ),
            ),
          if (material == Material.turf)
            ListTile(
              title: const Text('Rubber Coated Sand'),
              leading: Radio<TurfMaterial>(
                value: TurfMaterial.rubberCoatedSand,
                groupValue: turfMaterial,
                onChanged: (TurfMaterial? value) {
                  setState(() {
                    turfMaterial = value;
                  });
                },
              ),
            ),
          if (material == Material.turf)
            const Padding(padding: EdgeInsets.all(8.0)),
          if (material == Material.turf)
            Container(color: Colors.black, height: 2.0,),
          if (material == Material.turf)
            const Padding(padding: EdgeInsets.all(8.0)),
          if (material == Material.turf)
            const Text(
              'Extra Lines',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
          if (material == Material.turf)
            ListTile(
              title: const Text('Yes'),
              leading: Radio<ExtraLines>(
                value: ExtraLines.yes,
                groupValue: extraLines,
                onChanged: (ExtraLines? value) {
                  setState(() {
                    extraLines = value;
                  });
                },
              ),
            ),
          if (material == Material.turf)
            ListTile(
              title: const Text('No'),
              leading: Radio<ExtraLines>(
                value: ExtraLines.no,
                groupValue: extraLines,
                onChanged: (ExtraLines? value) {
                  setState(() {
                    extraLines = value;
                  });
                },
              ),
            ),
          if (material == Material.turf)
            const Padding(padding: EdgeInsets.all(8.0)),
          if (material == Material.turf)
            Container(color: Colors.black, height: 2.0,),
          if (material == Material.turf)
            const Padding(padding: EdgeInsets.all(8.0)),
          if(extraLines == ExtraLines.yes)
            const Text(
              'Visibility of Correct Lines',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
          if(extraLines == ExtraLines.yes)
            const Padding(padding: EdgeInsets.all(8.0)),
          if(extraLines == ExtraLines.yes)
            Text(
                'Rating: $linesExtra',
                style: const TextStyle(
                    fontSize: 20.0
                )
            ),
          if(extraLines == ExtraLines.yes)
            const Padding(padding: EdgeInsets.all(8.0)),
          if(extraLines == ExtraLines.yes)
            RatingBar.builder(
                minRating: 1,
                maxRating: 10,
                itemSize: 30,
                itemCount: 5,
                itemBuilder: (context, _) =>
                const Icon(Icons.star, color: Colors.black),
                onRatingUpdate: (rating) =>
                    setState(() {
                      linesExtra = rating;
                    })
            ),
          if(extraLines == ExtraLines.yes)
            const Padding(padding: EdgeInsets.all(8.0)),
          if(extraLines == ExtraLines.yes)
            Container(color: Colors.black, height: 2.0,),
          if(extraLines == ExtraLines.yes)
            const Padding(padding: EdgeInsets.all(8.0)),
          if (material == Material.turf)
            const Text(
              'Bounciness',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30.0,
              ),
            ),
          if (material == Material.turf)
            const Padding(padding: EdgeInsets.all(8.0)),
          if (material == Material.turf)
            Text(
                'Rating: $bounciness',
                style: const TextStyle(
                    fontSize: 20.0
                )
            ),
          if (material == Material.turf)
            const Padding(padding: EdgeInsets.all(8.0)),
          if (material == Material.turf)
            RatingBar.builder(
                minRating: 1,
                maxRating: 10,
                itemSize: 30,
                itemCount: 5,
                itemBuilder: (context, _) =>
                const Icon(Icons.star, color: Colors.black),
                updateOnDrag: true,
                onRatingUpdate: (rating) =>
                    setState(() {
                      bounciness = rating;
                    })
            ),
          if (material == Material.turf)
            const Padding(padding: EdgeInsets.all(8.0)),
          if (material == Material.turf)
            Container(color: Colors.black, height: 2.0,),
          if (material == Material.turf)
            const Padding(padding: EdgeInsets.all(8.0)),
          const Text(
            'Direction',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
          ListTile(
            title: const Text('East/West'),
            leading: Radio<Direction>(
              value: Direction.eastWest,
              groupValue: direction,
              onChanged: (Direction? value) {
                setState(() {
                  direction = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('North/South'),
            leading: Radio<Direction>(
              value: Direction.northSouth,
              groupValue: direction,
              onChanged: (Direction? value) {
                setState(() {
                  direction = value;
                });
              },
            ),
          ),
          const Padding(padding: EdgeInsets.all(8.0)),
          Container(color: Colors.black, height: 2.0,),
          const Padding(padding: EdgeInsets.all(8.0)),
          const Text(
            'Seating',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
          ListTile(
            title: const Text('No Seating'),
            leading: Radio<Seating>(
              value: Seating.none,
              groupValue: seating,
              onChanged: (Seating? value) {
                setState(() {
                  seating = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Small Stands (1-30 people)'),
            leading: Radio<Seating>(
              value: Seating.small,
              groupValue: seating,
              onChanged: (Seating? value) {
                setState(() {
                  seating = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Medium Stands (30-100 people)'),
            leading: Radio<Seating>(
              value: Seating.medium,
              groupValue: seating,
              onChanged: (Seating? value) {
                setState(() {
                  seating = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Large Stands (100-1000 people)'),
            leading: Radio<Seating>(
              value: Seating.large,
              groupValue: seating,
              onChanged: (Seating? value) {
                setState(() {
                  seating = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('Stadium (1000+ people)'),
            leading: Radio<Seating>(
              value: Seating.stadium,
              groupValue: seating,
              onChanged: (Seating? value) {
                setState(() {
                  seating = value;
                });
              },
            ),
          ),
          const Padding(padding: EdgeInsets.all(8.0)),
          Container(color: Colors.black, height: 2.0,),
          const Padding(padding: EdgeInsets.all(8.0)),
          const Text(
            'Requires Reservation',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
          ListTile(
            title: const Text('Yes'),
            leading: Radio<Reservation>(
              value: Reservation.yes,
              groupValue: _reservation,
              onChanged: (Reservation? value) {
                setState(() {
                  _reservation = value;
                });
              },
            ),
          ),
          ListTile(
            title: const Text('No'),
            leading: Radio<Reservation>(
              value: Reservation.no,
              groupValue: _reservation,
              onChanged: (Reservation? value) {
                setState(() {
                  _reservation = value;
                });
              },
            ),
          ),
          const Padding(padding: EdgeInsets.all(8.0)),
          Container(color: Colors.black, height: 2.0,),
          const Padding(padding: EdgeInsets.all(8.0)),
          const Text(
            'Add Comments',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30.0,
            ),
          ),
          TextFormField(
            controller: comment,
            decoration: const InputDecoration(
              hintText: 'Comment',
              contentPadding: EdgeInsets.fromLTRB(5, 15, 0, 0),
            ),
            maxLines: null,
          ),
          Container(color: Colors.black, height: 2.0,),
          const Padding(padding: EdgeInsets.all(50.0)),
          ElevatedButton(
            onPressed: () async {
              final id = await DataService.getRowCount1() + 1;

              final ratings = Ratings(
                id: id,
                rating: rating,
                grassLength: grassLength,
                bumpiness: bumpiness,
                slant: slant,
                hardness: hardness,
                linesExtra: linesExtra,
                bounciness: bounciness,
                indoorOutdoor: _indoorOutdoor.toString(),
                length: length.toString(),
                width: width.toString(),
                material: material.toString(),
                turfMaterial: turfMaterial.toString(),
                extraLines: extraLines.toString(),
                direction: direction.toString(),
                seating: seating.toString(),
                reservation: _reservation.toString(),
                comment: comment.text,
                address: place.address
              );
              await DataService.insert1([ratings.toJson()]);

              Navigator.pop(context);
            },
            child: const Text('Submit'),
          )
        ],
      ),
    );
  }
}
