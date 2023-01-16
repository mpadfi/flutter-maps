// To parse this JSON data, do
//
//     final placesResponse = placesResponseFromJson(jsonString);

import 'dart:convert';

class PlacesResponse {
  PlacesResponse({
    required this.type,
    // required this.query,
    required this.features,
    required this.attribution,
  });

  final String type;
  // final List<String> query;
  final List<Feature> features;
  final String attribution;

  factory PlacesResponse.fromRawJson(String str) => PlacesResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlacesResponse.fromJson(Map<String, dynamic> json) => PlacesResponse(
        type: json["type"],
        // query: List<String>.from(json["query"].map((x) => x)),
        features: List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
        attribution: json["attribution"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        // "query": List<dynamic>.from(query.map((x) => x)),
        "features": List<dynamic>.from(features.map((x) => x.toJson())),
        "attribution": attribution,
      };
}

class Feature {
  Feature({
    required this.id,
    required this.type,
    required this.placeType,
    required this.properties,
    required this.text,
    required this.placeName,
    required this.center,
    required this.geometry,
    required this.context,
    required this.matchingText,
    required this.matchingPlaceName,
  });

  final String id;
  final String type;
  final List<String> placeType;
  final Properties properties;
  final String text;
  final String placeName;
  final List<double> center;
  final Geometry geometry;
  final List<Context?>? context;
  final String? matchingText;
  final String? matchingPlaceName;

  factory Feature.fromRawJson(String str) => Feature.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        id: json["id"],
        type: json["type"],
        placeType: List<String>.from(json["place_type"].map((x) => x)),
        properties: Properties.fromJson(json["properties"]),
        text: json["text"],
        placeName: json["place_name"],
        center: List<double>.from(json["center"].map((x) => x.toDouble())),
        geometry: Geometry.fromJson(json["geometry"]),
        context: json["context"] == null ? [] : List<Context?>.from(json["context"]!.map((x) => Context.fromJson(x))),
        matchingText: json["matching_text"],
        matchingPlaceName: json["matching_place_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "place_type": List<dynamic>.from(placeType.map((x) => x)),
        "properties": properties.toJson(),
        "text": text,
        "place_name": placeName,
        "center": List<dynamic>.from(center.map((x) => x)),
        "geometry": geometry.toJson(),
        "context": context == null ? [] : List<dynamic>.from(context!.map((x) => x!.toJson())),
        "matching_text": matchingText,
        "matching_place_name": matchingPlaceName,
      };
  @override
  String toString() {
    return 'Feature: $text';
  }
}

class Context {
  Context({
    required this.id,
    required this.text,
    required this.wikidata,
    required this.shortCode,
  });

  final String id;
  final String text;
  final String? wikidata;
  final String? shortCode;

  factory Context.fromRawJson(String str) => Context.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Context.fromJson(Map<String, dynamic> json) => Context(
        id: json["id"],
        text: json["text"],
        wikidata: json["wikidata"],
        shortCode: json["short_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
        "wikidata": wikidata,
        "short_code": shortCode,
      };
}

class Geometry {
  Geometry({
    required this.coordinates,
    required this.type,
  });

  final List<double> coordinates;
  final String type;

  factory Geometry.fromRawJson(String str) => Geometry.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "type": type,
      };
}

class Properties {
  Properties({
    required this.wikidata,
    required this.address,
    required this.landmark,
    required this.foursquare,
    required this.category,
    required this.maki,
  });

  final String? wikidata;
  final String? address;
  final bool? landmark;
  final String? foursquare;
  final String? category;
  final String? maki;

  factory Properties.fromRawJson(String str) => Properties.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        wikidata: json["wikidata"],
        address: json["address"],
        landmark: json["landmark"],
        foursquare: json["foursquare"],
        category: json["category"],
        maki: json["maki"],
      );

  Map<String, dynamic> toJson() => {
        "wikidata": wikidata,
        "address": address,
        "landmark": landmark,
        "foursquare": foursquare,
        "category": category,
        "maki": maki,
      };
}
