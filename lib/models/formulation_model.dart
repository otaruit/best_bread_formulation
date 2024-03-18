// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/foundation.dart';

@immutable
class Formulation {
  final String recipeName;
  final double versions;
  final DateTime? revisionDate;
  final DateTime? creationDate;
  final int strongFlour;
  final int weakFlour;
  final int butter;
  final int sugar;
  final int salt;
  final int skimMilk;
  final int east;
  final int water;
  final String uid;
  final String id;
  final List<String> likes;
  final List<String> commentIds;
  final List<String> imageLinks;
  const Formulation({
    required this.recipeName,
    required this.versions,
    required this.revisionDate,
    required this.creationDate,
    required this.strongFlour,
    required this.weakFlour,
    required this.butter,
    required this.sugar,
    required this.salt,
    required this.skimMilk,
    required this.east,
    required this.water,
    required this.uid,
    required this.id,
    required this.likes,
    required this.commentIds,
    required this.imageLinks,
  });

  Formulation copyWith({
    String? recipeName,
    double? versions,
    DateTime? revisionDate,
    DateTime? creationDate,
    int? strongFlour,
    int? weakFlour,
    int? butter,
    int? sugar,
    int? salt,
    int? skimMilk,
    int? east,
    int? water,
    String? uid,
    String? id,
    List<String>? likes,
    List<String>? commentIds,
    List<String>? imageLinks,
  }) {
    return Formulation(
      recipeName: recipeName ?? this.recipeName,
      versions: versions ?? this.versions,
      revisionDate: revisionDate ?? this.revisionDate,
      creationDate: creationDate ?? this.creationDate,
      strongFlour: strongFlour ?? this.strongFlour,
      weakFlour: weakFlour ?? this.weakFlour,
      butter: butter ?? this.butter,
      sugar: sugar ?? this.sugar,
      salt: salt ?? this.salt,
      skimMilk: skimMilk ?? this.skimMilk,
      east: east ?? this.east,
      water: water ?? this.water,
      uid: uid ?? this.uid,
      id: id ?? this.id,
      likes: likes ?? this.likes,
      commentIds: commentIds ?? this.commentIds,
      imageLinks: imageLinks ?? this.imageLinks,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'recipeName': recipeName,
      'versions': versions,
      'revisionDate': revisionDate!.millisecondsSinceEpoch,
      'creationDate': creationDate!.millisecondsSinceEpoch,
      'strongFlour': strongFlour,
      'weakFlour': weakFlour,
      'butter': butter,
      'sugar': sugar,
      'salt': salt,
      'skimMilk': skimMilk,
      'east': east,
      'water': water,
      'uid': uid,
      'id': id,
      'likes': likes,
      'commentIds': commentIds,
      'imageLinks': imageLinks,
    };
  }

  factory Formulation.fromMap(Map<String, dynamic> map) {
    return Formulation(
      recipeName: map['recipeName'] ?? '',
      versions: map['versions']?.toDouble() ?? 0,
        revisionDate:
            DateTime.fromMillisecondsSinceEpoch(map['revisionDate']),
        creationDate:
            DateTime.fromMillisecondsSinceEpoch(map['creationDate']),
      strongFlour: map['strongFlour']?.toInt() ?? 0,
      weakFlour: map['weakFlour']?.toInt() ?? 0,
      butter: map['butter']?.toInt() ?? 0,
      sugar: map['sugar']?.toInt() ?? 0,
      salt: map['salt']?.toInt() ?? 0,
      skimMilk: map['skimMilk']?.toInt() ?? 0,
      east: map['east']?.toInt() ?? 0,
      water: map['water']?.toInt() ?? 0,
      uid: map['uid'] ?? '',
      id: map['\$id'] ?? '',
      likes: List<String>.from(map['likes']),
      commentIds: List<String>.from(map['commentIds']),
      imageLinks: List<String>.from(map['imageLinks']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Formulation.fromJson(String source) =>
      Formulation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Formulation(recipeName: $recipeName, versions: $versions, revisionDate: $revisionDate, creationDate: $creationDate, strongFlour: $strongFlour, weakFlour: $weakFlour, butter: $butter, sugar: $sugar, salt: $salt, skimMilk: $skimMilk, east: $east, water: $water, uid: $uid, id: $id, likes: $likes, commentIds: $commentIds, imageLinks: $imageLinks)';
  }

  @override
  bool operator ==(covariant Formulation other) {
    if (identical(this, other)) return true;
  
    return other.recipeName == recipeName &&
        other.versions == versions &&
        other.revisionDate == revisionDate &&
        other.creationDate == creationDate &&
        other.strongFlour == strongFlour &&
        other.weakFlour == weakFlour &&
        other.butter == butter &&
        other.sugar == sugar &&
        other.salt == salt &&
        other.skimMilk == skimMilk &&
        other.east == east &&
        other.water == water &&
        other.uid == uid &&
        other.id == id &&
        listEquals(other.likes, likes) &&
        listEquals(other.commentIds, commentIds) &&
        listEquals(other.imageLinks, imageLinks);
  }

  @override
  int get hashCode {
    return recipeName.hashCode ^
        versions.hashCode ^
        revisionDate.hashCode ^
        creationDate.hashCode ^
        strongFlour.hashCode ^
        weakFlour.hashCode ^
        butter.hashCode ^
        sugar.hashCode ^
        salt.hashCode ^
        skimMilk.hashCode ^
        east.hashCode ^
        water.hashCode ^
        uid.hashCode ^
        id.hashCode ^
        likes.hashCode ^
        commentIds.hashCode ^
        imageLinks.hashCode;
  }
}
