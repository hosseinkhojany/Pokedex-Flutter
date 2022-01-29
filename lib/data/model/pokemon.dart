import 'dart:convert';


List<Pokemon> pokemonFromJson(String str) =>
    List<Pokemon>.from(json.decode(str).map((x) => Pokemon.fromJson(x)));

class Pokemon{

  Pokemon({required this.name, required this.url});

  String name;
  String url;

  String getImage(){
    return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${url.split("/")[url.split("/").length - 2]}.png";
  }

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
      name: json["name"],
      url: json["url"]
  );

}