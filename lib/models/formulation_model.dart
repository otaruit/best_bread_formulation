// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

@immutable
class Formulation {
  final String recipeName;
  final int versions;
  final DateTime revisionDate;
  final DateTime creationDate;
  final int strongFlour;
  final int weakFlour;
  final int butter;
  final int sugar;
  final int salt;
  final int skimMilk;
  final int water;
  final String uid;
  final String id;
  final List<String> likes;
  final List<String> commentIds;
  final List<String> imageLinks;
  Formulation({
    this.recipeName = '',
    this.versions = 0,
    required this.revisionDate,
    required this.creationDate,
    this.strongFlour = 0,
    this.weakFlour = 0,
    this.butter = 0,
    this.sugar = 0,
    this.salt = 0,
    this.skimMilk = 0,
    this.water = 0,
    this.uid = '',
    this.id = '',
    this.likes = const [],
    this.commentIds = const [],
    this.imageLinks = const [],
  });

  Formulation copyWith({
    String? recipeName,
    int? versions,
    DateTime? revisionDate,
    DateTime? creationDate,
    int? strongFlour,
    int? weakFlour,
    int? butter,
    int? sugar,
    int? salt,
    int? skimMilk,
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
      'revisionDate': revisionDate.millisecondsSinceEpoch,
      'creationDate': creationDate.millisecondsSinceEpoch,
      'strongFlour': strongFlour,
      'weakFlour': weakFlour,
      'butter': butter,
      'sugar': sugar,
      'salt': salt,
      'skimMilk': skimMilk,
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
      recipeName: map['recipeName'] as String,
      versions: map['versions'] as int,
      revisionDate:
          DateTime.fromMillisecondsSinceEpoch(map['revisionDate'] as int),
      creationDate:
          DateTime.fromMillisecondsSinceEpoch(map['creationDate'] as int),
      strongFlour: map['strongFlour'] as int,
      weakFlour: map['weakFlour'] as int,
      butter: map['butter'] as int,
      sugar: map['sugar'] as int,
      salt: map['salt'] as int,
      skimMilk: map['skimMilk'] as int,
      water: map['water'] as int,
      uid: map['uid'] as String,
      id: map['id'] as String,
      likes: List<String>.from((map['likes'] as List<String>)),
      commentIds: List<String>.from(map['commentIds'] as List<String>),
      imageLinks: List<String>.from(map['imageLinks'] as List<String>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Formulation.fromJson(String source) =>
      Formulation.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Formulation(recipeName: $recipeName, versions: $versions, revisionDate: $revisionDate, creationDate: $creationDate, strongFlour: $strongFlour, weakFlour: $weakFlour, butter: $butter, sugar: $sugar, salt: $salt, skimMilk: $skimMilk, water: $water, uid: $uid, id: $id, likes: $likes, commentIds: $commentIds, imageLinks: $imageLinks)';
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
        water.hashCode ^
        uid.hashCode ^
        id.hashCode ^
        likes.hashCode ^
        commentIds.hashCode ^
        imageLinks.hashCode;
  }
}
