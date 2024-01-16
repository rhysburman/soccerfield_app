import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_making_practice/blocs/models/place.dart';
import 'package:form_making_practice/blocs/models/ratings.dart';
import 'package:form_making_practice/services/data_service.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({Key? key,  required this.place}) : super(key: key);

  final Place place;

  @override
  _ReviewScreenState createState() => _ReviewScreenState(place: place);
}

class _ReviewScreenState extends State<ReviewScreen>{
  _ReviewScreenState({required this.place});

  List <int> nums = [];

  final Place place;

  List<Ratings> listOfRatings = [];

  String? name;
  String? address;

  @override
  void initState() {

    super.initState();

    getRatings();
    getComments();
 }

  Future<void> getRatings() async{
    final theRatings = await DataService.getAll();

    address = place.address;

    for (int i = 0; i < theRatings.length; i++) {
      if (theRatings[i].address == address) {
        setState(() {
          listOfRatings.add(theRatings[i]);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    name = place.name;
    return Scaffold(
      appBar: AppBar(
        title: const Text ('Review Screen'),
        backgroundColor: Colors.blue,
      ),
      body: ListView (
        padding: const EdgeInsets.fromLTRB(8, 15, 8, 8),
        children: [
          Text('Ratings for $name',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          const Padding(padding: EdgeInsets.all(8.0)),
          Text('Overall Rating: ${getAverageRating()}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const Padding(padding: EdgeInsets.all(8.0)),
          Text('The field is ${getMostIndoorOutdoor()} and the material is ${getMostMaterial()}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const Padding(padding: EdgeInsets.all(8.0)),
          Text('The field'"'"'s length is ${getMostLength()} and the width is ${getMostWidth()}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const Padding(padding: EdgeInsets.all(8.0)),
          if(getMostMaterial() == 'Turf')
            Text('The material of the turf is ${getMostTurfMaterial()} with a  bounciness rating of ${getAverageBounciness()}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          if(getMostMaterial() == 'Turf')
            const Padding(padding: EdgeInsets.all(8.0)),
          if (getMostExtraLines() == 'Yes')
            Text('The field has extra lines and the visibility of the true lines has a rating of ${getAverageLinesExtra()}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          if(getMostMaterial() == 'Turf')
            const Padding(padding: EdgeInsets.all(8.0)),
          if(getMostMaterial() == 'Grass')
            Text('The grass length has a rating of ${getAverageGrassLength()}\nThe bumpiness has a rating of ${getAverageBumpiness()}\n'
                'The slant has a rating of ${getAverageSlant()}\nThe hardness has a rating of ${getAverageHardness()}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          if(getMostMaterial() == 'Grass')
            const Padding(padding: EdgeInsets.all(8.0)),
          Text('The field faces ${getMostDirection()}\nThe field ${getMostReservation()} require a reservation\nThere is seating for ${getMostSeating()}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const Padding(padding: EdgeInsets.all(8.0)),
          Text('Comments:\n${theComments()}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      )
    );
  }


  getAverageRating () {
    int counter = 0;
    double total = 0;

    for (int i = 0; i < listOfRatings.length; i++) {
      if (listOfRatings[i].rating != null) {
        total = total + double.parse(listOfRatings[i].rating.toString());
        counter++;
      }
    }

    if (counter == 0) {
      return 'N/A';
    }
    else {
      return (total / counter);
    }
  }

  getAverageGrassLength () {
    int counter = 0;
    double total = 0;

    for (int i = 0; i < listOfRatings.length; i++){
      if (listOfRatings[i].grassLength != null) {
        total = total + double.parse(listOfRatings[i].grassLength.toString());
        counter++;
      }
    }

    if (counter == 0) {
      return 'N/A';
    }
    else {
      return (total/counter);
    }
  }

  getAverageBumpiness () {
    int counter = 0;
    double total = 0;

    for (int i = 0; i < listOfRatings.length; i++){
      if (listOfRatings[i].bumpiness != null) {
        total = total + double.parse(listOfRatings[i].bumpiness.toString());
        counter++;
      }
    }

    if (counter == 0) {
      return 'N/A';
    }
    else {
      return (total/counter);
    }
  }

  getAverageSlant () {
    int counter = 0;
    double total = 0;

    for (int i = 0; i < listOfRatings.length; i++){
      if (listOfRatings[i].slant != null) {
        total = total + double.parse(listOfRatings[i].slant.toString());
        counter++;
      }
    }

    if (counter == 0) {
      return 'N/A';
    }
    else {
      return (total/counter);
    }
  }

  getAverageHardness () {
    int counter = 0;
    double total = 0;

    for (int i = 0; i < listOfRatings.length; i++){
      if (listOfRatings[i].hardness != null) {
        total = total + double.parse(listOfRatings[i].hardness.toString());
        counter++;
      }
    }

    if (counter == 0) {
      return 'N/A';
    }
    else {
      return (total/counter);
    }
  }

  getAverageLinesExtra () {
    int counter = 0;
    double total = 0;

    for (int i = 0; i < listOfRatings.length; i++){
      if (listOfRatings[i].linesExtra != null) {
        total = total + double.parse(listOfRatings[i].linesExtra.toString());
        counter++;
      }
    }

    if (counter == 0) {
      return 'N/A';
    }
    else {
      return (total/counter);
    }
  }

  getAverageBounciness () {
    int counter = 0;
    double total = 0;

    for (int i = 0; i < listOfRatings.length; i++){
      if (listOfRatings[i].bounciness != null) {
        total = total + double.parse(listOfRatings[i].bounciness.toString());
        counter++;
      }
    }

    if (counter == 0) {
      return 'N/A';
    }
    else {
      return (total/counter);
    }
  }

  getMostIndoorOutdoor () {
    List<String> keywords = ['indoorOutdoor.outdoor', 'indoorOutdoor.indoor'];
    List<int> counter = [0, 0];
    for (int i = 0; i < listOfRatings.length; i++){
      if (listOfRatings[i].indoorOutdoor == keywords[0]){
        counter[0]++;
      }
      else{
        counter[1]++;
      }
    }
    int max = 0;
    int value = 0;
    for (int i = 0; i < counter.length; i++){
      if (counter[i] > max){
        max = counter[i];
        value = i;
      }
    }

    if (keywords[value] == 'indoorOutdoor.outdoor'){
      return 'outdoor';
    }
    else{
      return 'indoor';
    }
  }

  getMostLength () {
    List<String> keywords = ['Length.short', 'Length.medium', 'Length.long'];
    List<int> counter = [0, 0, 0];
    for (int i = 0; i < listOfRatings.length; i++){
      if (listOfRatings[i].length == keywords[0]){
        counter[0]++;
      }
      if (listOfRatings[i].length == keywords[1]){
        counter[1]++;
      }
      else{
        counter[2]++;
      }
    }
    int max = 0;
    int value = 0;
    for (int i = 0; i < counter.length; i++){
      if (counter[i] > max){
        max = counter[i];
        value = i;
      }
    }

    if (keywords[value] == 'Length.short'){
      return 'less than 90 yards';
    }
    else if (keywords[value] == 'Length.medium'){
      return '90-110 yards';
    }
    else{
      return 'greater than 110 yards';
    }
  }

  getMostWidth () {
    List<String> keywords = ['Width.skinny', 'Width.medium', 'Width.wide'];
    List<int> counter = [0, 0, 0];
    for (int i = 0; i < listOfRatings.length; i++){
      if (listOfRatings[i].width == keywords[0]){
        counter[0]++;
      }
      if (listOfRatings[i].width == keywords[1]){
        counter[1]++;
      }
      else{
        counter[2]++;
      }
    }
    int max = 0;
    int value = 0;
    for (int i = 0; i < counter.length; i++){
      if (counter[i] > max){
        max = counter[i];
        value = i;
      }
    }

    if (keywords[value] == 'Width.skinny'){
      return '18-24 yards from the touchline';
    }
    else if (keywords[value] == 'Width.medium'){
      return '11-18 yards from the touchline';
    }
    else{
      return '5-11 yards from the touchline';
    }
  }

  getMostMaterial () {
    List<String> keywords = ['Material.turf', 'Material.grass'];
    List<int> counter = [0, 0];
    for (int i = 0; i < listOfRatings.length; i++){
      if (listOfRatings[i].material == keywords[0]){
        counter[0]++;
      }
      else{
        counter[1]++;
      }
    }

    int max = 0;
    int value = 0;
    for (int i = 0; i < counter.length; i++){
      if (counter[i] > max){
        max = counter[i];
        value = i;
      }
    }
    if (keywords[value] == 'Material.turf'){
      return 'turf';
    }
    else{
      return 'grass';
    }
  }

  getMostExtraLines () {
    List<String> keywords = ['ExtraLines.yes', 'ExtraLines.no'];
    List<int> counter = [0, 0];
    for (int i = 0; i < listOfRatings.length; i++){
      if (listOfRatings[i].extraLines == keywords[0]){
        counter[0]++;
      }
      else{
        counter[1]++;
      }
    }
    int max = 0;
    int value = 0;
    for (int i = 0; i < counter.length; i++){
      if (counter[i] > max){
        max = counter[i];
        value = i;
      }
    }

    if (keywords[value] == 'ExtraLines.yes'){
      return 'Yes';
    }
    else{
      return 'No';
    }
  }

  getMostDirection () {
    List<String> keywords = ['Direction.northSouth', 'Direction.eastWest'];
    List<int> counter = [0, 0];
    for (int i = 0; i < listOfRatings.length; i++){
      if (listOfRatings[i].direction == keywords[0]){
        counter[0]++;
      }
      else{
        counter[1]++;
      }
    }
    int max = 0;
    int value = 0;
    for (int i = 0; i < counter.length; i++){
      if (counter[i] > max){
        max = counter[i];
        value = i;
      }
    }

    if (keywords[value] == 'Direction.northSouth'){
      return 'north-south';
    }
    else{
      return 'east-west';
    }
  }

  getMostReservation () {
    List<String> keywords = ['Reservation.yes', 'Reservation.no'];
    List<int> counter = [0, 0];
    for (int i = 0; i < listOfRatings.length; i++) {
      if (listOfRatings[i].reservation == keywords[0]) {
        counter[0]++;
      }
      else {
        counter[1]++;
      }
    }
    int max = 0;
    int value = 0;
    for (int i = 0; i < counter.length; i++) {
      if (counter[i] > max) {
        max = counter[i];
        value = i;
      }
    }

    if (keywords[value] == 'Reservation.yes') {
      return 'does';
    }
    else {
      return "doesn't";
    }
  }

  getMostTurfMaterial () {
    List<String> keywords = ['TurfMaterial.coconutShavings', 'TurfMaterial.tireRubber','TurfMaterial.plasticPellets','TurfMaterial.sand','TurfMaterial.rubberCoatedSand'];
    List<int> counter = [0, 0, 0, 0, 0];
    for (int i = 0; i < listOfRatings.length; i++){
      if (listOfRatings[i].turfMaterial == keywords[0]){
        counter[0]++;
      }
      if (listOfRatings[i].turfMaterial == keywords[1]){
        counter[1]++;
      }
      if (listOfRatings[i].turfMaterial == keywords[2]){
        counter[2]++;
      }
      if (listOfRatings[i].turfMaterial == keywords[3]){
        counter[3]++;
      }
      else{
        counter[4]++;
      }
    }
    int max = 0;
    int value = 0;
    for (int i = 0; i < counter.length; i++){
      if (counter[i] > max){
        max = counter[i];
        value = i;
      }
    }

    if (keywords[value] == 'TurfMaterial.coconutShavings'){
      return 'Coconut Shavings';
    }
    else if (keywords[value] == 'TurfMaterial.tireRubber'){
      return 'Tire Rubber';
    }
    else if (keywords[value] == 'TurfMaterial.plasticPellets'){
      return 'Plastic Pellets';
    }
    else if (keywords[value] == 'TurfMaterial.sand'){
      return 'Sand';
    }
    else{
      return 'Rubber Coated Sand';
    }
  }


  getMostSeating () {
    List<String> keywords = ['Seating.none', 'Seating.small', 'Seating.medium', 'Seating.large', 'Seating.stadium'];
    List<int> counter = [0, 0, 0, 0, 0];
    for (int i = 0; i < listOfRatings.length; i++){
      if (listOfRatings[i].seating == keywords[0]){
        counter[0]++;
      }
      if (listOfRatings[i].seating == keywords[1]){
        counter[1]++;
      }
      if (listOfRatings[i].seating == keywords[2]){
        counter[2]++;
      }
      if (listOfRatings[i].seating == keywords[3]){
        counter[3]++;
      }
      else{
        counter[4]++;
      }
    }
    int max = 0;
    int value = 0;
    for (int i = 0; i < counter.length; i++){
      if (counter[i] > max){
        max = counter[i];
        value = i;
      }
    }

    if (keywords[value] == 'Seating.none'){
      return '0 people (no official seating)';
    }
    else if (keywords[value] == 'Seating.small'){
      return '0-30 people (small seating)';
    }
    else if (keywords[value] == 'Seating.medium'){
      return '30-100 people (medium seating)';
    }
    else if (keywords[value] == 'Seating.large'){
      return '100-1000 people (large seating)';
    }
    else{
      return 'more than 1000 people (stadium seating)';
    }
  }

  getComments() {
    int comments = 0;
    for (int i = 0; i < listOfRatings.length; i++){
      if (listOfRatings[i].comment != null){
        comments++;
      }
    }

    if (comments <= 3){
      for (int i = 0; i < comments; i++){
        nums.add(i+1);
      }
    }

    else{
      Random random = Random();

      for (int i = 1; i <= 3; i++) {
        nums.add(random.nextInt(listOfRatings.length).toInt());
        for (int j = 0; i < nums.length - 1; j++) {
          if (nums[i] == nums[j]) {
            nums.removeAt(i);
            i--;
          }
        }
      }
    }

    return nums;
  }

  theComments() {
    String comments = '';
    int num = 1;

    for (int i = listOfRatings.length-1; i >= 0; i--){
      comments = '$comments $num.${listOfRatings[i].comment}\n';
      num++;
    }

   return comments;

  }
}