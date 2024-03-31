// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';

@immutable
class Formulation {
  final double version;
  final DateTime? creationDate;
  final int strongFlour;
  final int weakFlour;
  final int butter;
  final int sugar;
  final int salt;
  final int skimMilk;
  final int east;
  final int water;
  final String id;
  final String recipeId;
  const Formulation({
    this.version = 0.0,
    required this.creationDate,
    required this.strongFlour,
    required this.weakFlour,
    required this.butter,
    required this.sugar,
    required this.salt,
    required this.skimMilk,
    required this.east,
    required this.water,
    required this.id,
    required this.recipeId,
  });

  Formulation copyWith({
    double? version,
    DateTime? creationDate,
    int? strongFlour,
    int? weakFlour,
    int? butter,
    int? sugar,
    int? salt,
    int? skimMilk,
    int? east,
    int? water,
    String? id,
    String? recipeId,
  }) {
    return Formulation(
      version: version ?? this.version,
      creationDate: creationDate ?? this.creationDate,
      strongFlour: strongFlour ?? this.strongFlour,
      weakFlour: weakFlour ?? this.weakFlour,
      butter: butter ?? this.butter,
      sugar: sugar ?? this.sugar,
      salt: salt ?? this.salt,
      skimMilk: skimMilk ?? this.skimMilk,
      east: east ?? this.east,
      water: water ?? this.water,
      id: id ?? this.id,
      recipeId: recipeId ?? this.recipeId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'version': version,
      'creationDate': creationDate?.millisecondsSinceEpoch,
      'strongFlour': strongFlour,
      'weakFlour': weakFlour,
      'butter': butter,
      'sugar': sugar,
      'salt': salt,
      'skimMilk': skimMilk,
      'east': east,
      'water': water,
      'recipeId': recipeId,
    };
  }

  factory Formulation.fromMap(Map<String, dynamic> map) {
    return Formulation(
      version: map['version'] as double,
      creationDate: map['creationDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['creationDate'] as int)
          : null,
      strongFlour: map['strongFlour'] as int,
      weakFlour: map['weakFlour'] as int,
      butter: map['butter'] as int,
      sugar: map['sugar'] as int,
      salt: map['salt'] as int,
      skimMilk: map['skimMilk'] as int,
      east: map['east'] as int,
      water: map['water'] as int,
      id: map['\$id'] as String,
      recipeId: map['recipeId'] as String,
    );
  }

  @override
  String toString() {
    return 'Formulation(version: $version, creationDate: $creationDate, strongFlour: $strongFlour, weakFlour: $weakFlour, butter: $butter, sugar: $sugar, salt: $salt, skimMilk: $skimMilk, east: $east, water: $water, id: $id, recipeId: $recipeId)';
  }

  @override
  bool operator ==(covariant Formulation other) {
    if (identical(this, other)) return true;
  
    return other.version == version &&
        other.creationDate == creationDate &&
        other.strongFlour == strongFlour &&
        other.weakFlour == weakFlour &&
        other.butter == butter &&
        other.sugar == sugar &&
        other.salt == salt &&
        other.skimMilk == skimMilk &&
        other.east == east &&
        other.water == water &&
        other.id == id &&
        other.recipeId == recipeId;
  }

  @override
  int get hashCode {
    return version.hashCode ^
        creationDate.hashCode ^
        strongFlour.hashCode ^
        weakFlour.hashCode ^
        butter.hashCode ^
        sugar.hashCode ^
        salt.hashCode ^
        skimMilk.hashCode ^
        east.hashCode ^
        water.hashCode ^
        id.hashCode ^
        recipeId.hashCode;
  }

  toJson() {}
}
