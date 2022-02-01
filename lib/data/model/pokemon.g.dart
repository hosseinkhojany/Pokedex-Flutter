import 'dart:convert';

import 'package:hive_flutter/adapters.dart';


List<Pokemon> pokemonFromJson(String str) =>
    List<Pokemon>.from(json.decode(str).map((x) => Pokemon.fromJson(x)));

@HiveType(typeId: 1)
class Pokemon extends HiveObject{

  Pokemon(this.name, this.url);
  
  @HiveField(0)
  String name;
  @HiveField(1)
  String url;

  String getImage(){
    return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${url.split("/")[url.split("/").length - 2]}.png";
  }

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
      json["name"],
      json["url"]
  );

}