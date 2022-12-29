import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

List<Animal> modelStateFromMap(String str) =>
    List<Animal>.from(json.decode(str).map((x) => Animal.fromMap(x)));

String modelStateToMap(List<Animal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Animal {
  String? name;
  String? scientificName;
  double? age;
  String? distanceToUser;
  bool? isFemale;
  String? imageUrl;
  String? backgroundColor;

  Animal({
    this.name,
    this.scientificName,
    this.age,
    this.distanceToUser,
    this.isFemale,
    this.imageUrl,
    this.backgroundColor,
  });

  factory Animal.fromMap(Map<String, dynamic> json) => Animal(
        isFemale: (json["isFemale"] == null) ? null : json["isFemale"],
        name: (json["name"] == null) ? null : json["name"],
        scientificName:
            (json["scientificName"] == null) ? null : json["scientificName"],
        age: (json["age"] == null) ? null : json["age"],
        distanceToUser:
            (json["distanceToUser"] == null) ? null : json["distanceToUser"],
        imageUrl: (json["imageUrl"] == null) ? null : json["imageUrl"],
        backgroundColor:
            (json["backgroundColor"] == null) ? null : json["backgroundColor"],
      );

  Map<String, dynamic> toMap() => {
        "scientificName": (scientificName == null) ? null : scientificName,
        "isFemale": (isFemale == null) ? null : isFemale,
        "name": (name == null) ? null : name,
        "age": (age == null) ? null : age,
        "distanceToUser": (distanceToUser == null) ? null : distanceToUser,
        "imageUrl": (imageUrl == null) ? null : imageUrl,
        "backgroundColor": (backgroundColor == null) ? null : backgroundColor,
      };
}

Future<List<Animal>> loadPetList() async {
  var petModel;
  try {
    String response = await rootBundle.loadString('assets/pet.json');

    List<dynamic> result = json.decode(response);
    petModel = result.map((n) => Animal.fromMap(n)).toList();
    return petModel;
  } catch (e) {
    return petModel;
  }
}
