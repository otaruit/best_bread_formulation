// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

@immutable
class Recipe {
  final String recipeId;
  final double latestVersion;
  final String uid;
  final List<String> imageLinks;
  final String recipeName;
  const Recipe({
    this.recipeId = '',
    this.latestVersion = 0.0,
    this.uid = '',
    this.imageLinks = const [],
    this.recipeName = '',
  });

  Recipe copyWith({
    String? recipeId,
    double? latestVersion,
    String? uid,
    List<String>? imageLinks,
    String? recipeName,
  }) {
    return Recipe(
      recipeId: recipeId ?? this.recipeId,
      latestVersion: latestVersion ?? this.latestVersion,
      uid: uid ?? this.uid,
      imageLinks: imageLinks ?? this.imageLinks,
      recipeName: recipeName ?? this.recipeName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latestVersion': latestVersion,
      'uid': uid,
      'imageLinks': imageLinks,
      'recipeName': recipeName,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      recipeId: map['\$id'] as String,
      latestVersion: map['latestVersion'] as double,
      uid: map['uid'] as String,
      imageLinks: List<String>.from((map['imageLinks'] as List<String>)),
      recipeName: map['recipeName'] as String,
    );
  }

  @override
  String toString() {
    return 'Recipe(recipeId: $recipeId, latestVersion: $latestVersion, uid: $uid, imageLinks: $imageLinks, recipeName: $recipeName)';
  }

  @override
  bool operator ==(covariant Recipe other) {
    if (identical(this, other)) return true;

    return other.recipeId == recipeId &&
        other.latestVersion == latestVersion &&
        other.uid == uid &&
        listEquals(other.imageLinks, imageLinks) &&
        other.recipeName == recipeName;
  }

  @override
  int get hashCode {
    return recipeId.hashCode ^
        latestVersion.hashCode ^
        uid.hashCode ^
        imageLinks.hashCode ^
        recipeName.hashCode;
  }

  toJson() {}

  static fromJson(String map) {}
}
