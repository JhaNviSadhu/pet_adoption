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




// affenpinscher
// african
// airedale
// akita
// appenzeller
// shepherd australian
// basenji
// beagle
// bluetick
// borzoi
// bouvier
// boxer
// brabancon
// briard
// norwegian buhund
// boston bulldog
// english bulldog
// french bulldog
// staffordshire bullterrier
// australian cattledog
// chihuahua
// chow
// clumber
// cockapoo
// border collie
// coonhound
// cardigan corgi
// cotondetulear
// dachshund
// dalmatian
// great dane
// scottish deerhound
// dingo
// dhole
// doberman
// norwegian elkhound
// entlebucher
// eskimo
// lapphund finnish
// bichon frise
// germanshepherd
// italian greyhound
// groenendael
// havanese
// afghan hound
// basset hound
// blood hound
// english hound
// ibizan hound
// plott hound
// walker hound
// husky
// keeshond
// kelpie
// komondor</option>
// kuvasz</option>
// labradoodle</option>
// labrador</option>
// leonberg</option>
// lhasa</option>
// malamute</option>
// malinois</option>
// maltese</option>
// bull mastiff</option>
// english mastiff</option>
// tibetan mastiff</option>
// mexicanhairless</option>
// mix</option>
// bernese mountain</option>
// swiss mountain</option>
// newfoundland</option>
// otterhound</option>
// caucasian ovcharka</option>
// papillon</option>
// pekinese</option>
// pembroke</option>
// miniature pinscher</option>
// pitbull</option>
// german pointer</option>
// germanlonghair pointer</option>
// pomeranian</option>
// medium poodle</option>
// miniature poodle</option>
// standard poodle</option>
// toy poodle</option>
// pug</option>
// >puggle</option>
// pyrenees</option>
// redbone</option>
// chesapeake retriever</option>
// curly retriever</option>
// flatcoated retriever</option>
// golden retriever</option>
// rhodesian ridgeback</option>
// rottweiler</option>
// saluki</option>
// samoyed</option>
// schipperke</option>
// giant schnauzer</option>
// miniature schnauzer</option>
// italian segugio</option>
// english setter</option>
// gordon setter</option>
// irish setter</option>
// sharpei</option>
// english sheepdog</option>
// shetland sheepdog</option>
// shiba</option>
// shihtzu</option>
// blenheim spaniel</option>
// brittany spaniel</option>
// cocker spaniel</option>
// irish spaniel</option>
// japanese spaniel</option>
// sussex spaniel</option>
// welsh spaniel</option>
// japanese spitz</option>
// english springer</option>
// stbernard</option>
// <option value="terrier-american">american terrier</option>
// <option value="terrier-australian">australian terrier</option>
// <option value="terrier-bedlington">bedlington terrier</option>
// <option value="terrier-border">border terrier</option>
// <option value="terrier-cairn">cairn terrier</option>
// <option value="terrier-dandie">dandie terrier</option>
// <option value="terrier-fox">fox terrier</option>
// <option value="terrier-irish">irish terrier</option>
// <option value="terrier-kerryblue">kerryblue terrier</option>
// <option value="terrier-lakeland">lakeland terrier</option>
// <option value="terrier-norfolk">norfolk terrier</option>
// <option value="terrier-norwich">norwich terrier</option>
// <option value="terrier-patterdale">patterdale terrier</option>
// <option value="terrier-russell">russell terrier</option>
// <option value="terrier-scottish">scottish terrier</option>
// <option value="terrier-sealyham">sealyham terrier</option>
// <option value="terrier-silky">silky terrier</option>
// <option value="terrier-tibetan">tibetan terrier</option>
// <option value="terrier-toy">toy terrier</option>
// <option value="terrier-welsh">welsh terrier</option>
// <option value="terrier-westhighland">westhighland terrier</option>
// <option value="terrier-wheaten">wheaten terrier</option>
// <option value="terrier-yorkshire">yorkshire terrier</option>
// <option value="tervuren">tervuren</option>
// <option value="vizsla">vizsla</option>
// <option value="waterdog-spanish">spanish waterdog</option>
// <option value="weimaraner">weimaraner</option>
// <option value="whippet">whippet</option>
// <option value="wolfhound-irish">irish wolfhound</option>