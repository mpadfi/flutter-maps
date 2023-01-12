// To parse this JSON data, do
//
//     final trafficResponse = trafficResponseFromJson(jsonString);

import 'dart:convert';

class TrafficResponse {
  TrafficResponse({
    this.routes,
    this.waypoints,
    this.code,
    this.uuid,
  });

  final List<Route?>? routes;
  final List<Waypoint?>? waypoints;
  final String? code;
  final String? uuid;

  factory TrafficResponse.fromRawJson(String str) => TrafficResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TrafficResponse.fromJson(Map<String, dynamic> json) => TrafficResponse(
        routes: json["routes"] == null ? [] : List<Route?>.from(json["routes"]!.map((x) => Route.fromJson(x))),
        waypoints: json["waypoints"] == null ? [] : List<Waypoint?>.from(json["waypoints"]!.map((x) => Waypoint.fromJson(x))),
        code: json["code"],
        uuid: json["uuid"],
      );

  Map<String, dynamic> toJson() => {
        "routes": routes == null ? [] : List<dynamic>.from(routes!.map((x) => x!.toJson())),
        "waypoints": waypoints == null ? [] : List<dynamic>.from(waypoints!.map((x) => x!.toJson())),
        "code": code,
        "uuid": uuid,
      };
}

class Route {
  Route({
    this.countryCrossed,
    this.weightName,
    this.weight,
    this.duration,
    this.distance,
    this.legs,
    this.geometry,
  });

  final bool? countryCrossed;
  final String? weightName;
  final double? weight;
  final double? duration;
  final double? distance;
  final List<Leg?>? legs;
  final String? geometry;

  factory Route.fromRawJson(String str) => Route.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        countryCrossed: json["country_crossed"],
        weightName: json["weight_name"],
        weight: json["weight"].toDouble(),
        duration: json["duration"].toDouble(),
        distance: json["distance"].toDouble(),
        legs: json["legs"] == null ? [] : List<Leg?>.from(json["legs"]!.map((x) => Leg.fromJson(x))),
        geometry: json["geometry"],
      );

  Map<String, dynamic> toJson() => {
        "country_crossed": countryCrossed,
        "weight_name": weightName,
        "weight": weight,
        "duration": duration,
        "distance": distance,
        "legs": legs == null ? [] : List<dynamic>.from(legs!.map((x) => x!.toJson())),
        "geometry": geometry,
      };
}

class Leg {
  Leg({
    this.viaWaypoints,
    this.admins,
    this.weight,
    this.duration,
    this.steps,
    this.distance,
    this.summary,
  });

  final List<dynamic>? viaWaypoints;
  final List<Admin?>? admins;
  final double? weight;
  final double? duration;
  final List<Step?>? steps;
  final double? distance;
  final String? summary;

  factory Leg.fromRawJson(String str) => Leg.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Leg.fromJson(Map<String, dynamic> json) => Leg(
        viaWaypoints: json["via_waypoints"] == null ? [] : List<dynamic>.from(json["via_waypoints"]!.map((x) => x)),
        admins: json["admins"] == null ? [] : List<Admin?>.from(json["admins"]!.map((x) => Admin.fromJson(x))),
        weight: json["weight"].toDouble(),
        duration: json["duration"].toDouble(),
        steps: json["steps"] == null ? [] : List<Step?>.from(json["steps"]!.map((x) => Step.fromJson(x))),
        distance: json["distance"].toDouble(),
        summary: json["summary"],
      );

  Map<String, dynamic> toJson() => {
        "via_waypoints": viaWaypoints == null ? [] : List<dynamic>.from(viaWaypoints!.map((x) => x)),
        "admins": admins == null ? [] : List<dynamic>.from(admins!.map((x) => x!.toJson())),
        "weight": weight,
        "duration": duration,
        "steps": steps == null ? [] : List<dynamic>.from(steps!.map((x) => x!.toJson())),
        "distance": distance,
        "summary": summary,
      };
}

class Admin {
  Admin({
    this.iso31661Alpha3,
    this.iso31661,
  });

  final String? iso31661Alpha3;
  final String? iso31661;

  factory Admin.fromRawJson(String str) => Admin.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        iso31661Alpha3: json["iso_3166_1_alpha3"],
        iso31661: json["iso_3166_1"],
      );

  Map<String, dynamic> toJson() => {
        "iso_3166_1_alpha3": iso31661Alpha3,
        "iso_3166_1": iso31661,
      };
}

class Step {
  Step({
    this.intersections,
    this.maneuver,
    this.name,
    this.duration,
    this.distance,
    this.drivingSide,
    this.weight,
    this.mode,
    this.geometry,
    this.ref,
    this.destinations,
    this.rotaryName,
  });

  final List<Intersection?>? intersections;
  final Maneuver? maneuver;
  final String? name;
  final double? duration;
  final double? distance;
  final DrivingSide? drivingSide;
  final double? weight;
  final Mode? mode;
  final String? geometry;
  final String? ref;
  final String? destinations;
  final String? rotaryName;

  factory Step.fromRawJson(String str) => Step.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Step.fromJson(Map<String, dynamic> json) => Step(
        intersections: json["intersections"] == null ? [] : List<Intersection?>.from(json["intersections"]!.map((x) => Intersection.fromJson(x))),
        maneuver: Maneuver.fromJson(json["maneuver"]),
        name: json["name"],
        duration: json["duration"].toDouble(),
        distance: json["distance"].toDouble(),
        drivingSide: drivingSideValues.map[json["driving_side"]],
        weight: json["weight"].toDouble(),
        mode: modeValues.map[json["mode"]],
        geometry: json["geometry"],
        ref: json["ref"],
        destinations: json["destinations"],
        rotaryName: json["rotary_name"],
      );

  Map<String, dynamic> toJson() => {
        "intersections": intersections == null ? [] : List<dynamic>.from(intersections!.map((x) => x!.toJson())),
        "maneuver": maneuver!.toJson(),
        "name": name,
        "duration": duration,
        "distance": distance,
        "driving_side": drivingSideValues.reverse![drivingSide],
        "weight": weight,
        "mode": modeValues.reverse![mode],
        "geometry": geometry,
        "ref": ref,
        "destinations": destinations,
        "rotary_name": rotaryName,
      };
}

enum DrivingSide { LEFT, RIGHT, SLIGHT_LEFT, SLIGHT_RIGHT }

final drivingSideValues = EnumValues({"left": DrivingSide.LEFT, "right": DrivingSide.RIGHT, "slight left": DrivingSide.SLIGHT_LEFT, "slight right": DrivingSide.SLIGHT_RIGHT});

class Intersection {
  Intersection({
    this.entry,
    this.bearings,
    this.duration,
    this.mapboxStreetsV8,
    this.isUrban,
    this.adminIndex,
    this.out,
    this.weight,
    this.geometryIndex,
    this.location,
    this.intersectionIn,
    this.turnWeight,
    this.turnDuration,
    this.tunnelName,
    this.classes,
    this.yieldSign,
  });

  final List<bool?>? entry;
  final List<int?>? bearings;
  final double? duration;
  final MapboxStreetsV8? mapboxStreetsV8;
  final bool? isUrban;
  final int? adminIndex;
  final int? out;
  final double? weight;
  final int? geometryIndex;
  final List<double?>? location;
  final int? intersectionIn;
  final double? turnWeight;
  final double? turnDuration;
  final String? tunnelName;
  final List<ClassElement?>? classes;
  final bool? yieldSign;

  factory Intersection.fromRawJson(String str) => Intersection.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Intersection.fromJson(Map<String, dynamic> json) => Intersection(
        entry: json["entry"] == null ? [] : List<bool?>.from(json["entry"]!.map((x) => x)),
        bearings: json["bearings"] == null ? [] : List<int?>.from(json["bearings"]!.map((x) => x)),
        duration: json["duration"],
        mapboxStreetsV8: json["mapbox_streets_v8"],
        isUrban: json["is_urban"],
        adminIndex: json["admin_index"],
        out: json["out"],
        weight: json["weight"],
        geometryIndex: json["geometry_index"],
        location: json["location"] == null ? [] : List<double?>.from(json["location"]!.map((x) => x.toDouble())),
        intersectionIn: json["in"],
        turnWeight: json["turn_weight"],
        turnDuration: json["turn_duration"],
        tunnelName: json["tunnel_name"],
        classes: json["classes"] == null
            ? []
            : json["classes"] == null
                ? []
                : List<ClassElement?>.from(json["classes"]!.map((x) => classElementValues.map[x])),
        yieldSign: json["yield_sign"],
      );

  Map<String, dynamic> toJson() => {
        "entry": entry == null ? [] : List<dynamic>.from(entry!.map((x) => x)),
        "bearings": bearings == null ? [] : List<dynamic>.from(bearings!.map((x) => x)),
        "duration": duration,
        "mapbox_streets_v8": mapboxStreetsV8,
        "is_urban": isUrban,
        "admin_index": adminIndex,
        "out": out,
        "weight": weight,
        "geometry_index": geometryIndex,
        "location": location == null ? [] : List<dynamic>.from(location!.map((x) => x)),
        "in": intersectionIn,
        "turn_weight": turnWeight,
        "turn_duration": turnDuration,
        "tunnel_name": tunnelName,
        "classes": classes == null
            ? []
            : classes == null
                ? []
                : List<dynamic>.from(classes!.map((x) => classElementValues.reverse![x])),
        "yield_sign": yieldSign,
      };
}

enum ClassElement { TUNNEL, MOTORWAY }

final classElementValues = EnumValues({"motorway": ClassElement.MOTORWAY, "tunnel": ClassElement.TUNNEL});

class MapboxStreetsV8 {
  MapboxStreetsV8({
    this.mapboxStreetsV8Class,
  });

  final MapboxStreetsV8Class? mapboxStreetsV8Class;

  factory MapboxStreetsV8.fromRawJson(String str) => MapboxStreetsV8.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MapboxStreetsV8.fromJson(Map<String, dynamic> json) => MapboxStreetsV8(
        mapboxStreetsV8Class: mapboxStreetsV8ClassValues.map[json["class"]],
      );

  Map<String, dynamic> toJson() => {
        "class": mapboxStreetsV8ClassValues.reverse![mapboxStreetsV8Class],
      };
}

enum MapboxStreetsV8Class { STREET, TERTIARY, ROUNDABOUT, TRUNK, MOTORWAY, MOTORWAY_LINK, SECONDARY_LINK, SECONDARY, TERTIARY_LINK }

final mapboxStreetsV8ClassValues = EnumValues({
  "motorway": MapboxStreetsV8Class.MOTORWAY,
  "motorway_link": MapboxStreetsV8Class.MOTORWAY_LINK,
  "roundabout": MapboxStreetsV8Class.ROUNDABOUT,
  "secondary": MapboxStreetsV8Class.SECONDARY,
  "secondary_link": MapboxStreetsV8Class.SECONDARY_LINK,
  "street": MapboxStreetsV8Class.STREET,
  "tertiary": MapboxStreetsV8Class.TERTIARY,
  "tertiary_link": MapboxStreetsV8Class.TERTIARY_LINK,
  "trunk": MapboxStreetsV8Class.TRUNK
});

class Maneuver {
  Maneuver({
    this.type,
    this.instruction,
    this.bearingAfter,
    this.bearingBefore,
    this.location,
    this.modifier,
    this.exit,
  });

  final String? type;
  final String? instruction;
  final int? bearingAfter;
  final int? bearingBefore;
  final List<double?>? location;
  final DrivingSide? modifier;
  final int? exit;

  factory Maneuver.fromRawJson(String str) => Maneuver.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Maneuver.fromJson(Map<String, dynamic> json) => Maneuver(
        type: json["type"],
        instruction: json["instruction"],
        bearingAfter: json["bearing_after"],
        bearingBefore: json["bearing_before"],
        location: json["location"] == null ? [] : List<double?>.from(json["location"]!.map((x) => x.toDouble())),
        modifier: json["modifier"],
        exit: json["exit"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "instruction": instruction,
        "bearing_after": bearingAfter,
        "bearing_before": bearingBefore,
        "location": location == null ? [] : List<dynamic>.from(location!.map((x) => x)),
        "modifier": modifier,
        "exit": exit,
      };
}

enum Mode { DRIVING }

final modeValues = EnumValues({"driving": Mode.DRIVING});

class Waypoint {
  Waypoint({
    this.distance,
    this.name,
    this.location,
  });

  final double? distance;
  final String? name;
  final List<double?>? location;

  factory Waypoint.fromRawJson(String str) => Waypoint.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Waypoint.fromJson(Map<String, dynamic> json) => Waypoint(
        distance: json["distance"].toDouble(),
        name: json["name"],
        location: json["location"] == null ? [] : List<double?>.from(json["location"]!.map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "distance": distance,
        "name": name,
        "location": location == null ? [] : List<dynamic>.from(location!.map((x) => x)),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
