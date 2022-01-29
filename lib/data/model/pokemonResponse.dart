import 'package:untitled1/data/model/pokemon.dart';
import 'dart:convert';


List<Pokemon> pokemonListFromList(List<dynamic> list) {
  var listPokemon = <Pokemon>[];
  list.forEach((element) {
    listPokemon.add(Pokemon.fromJson(element));
  });
  return listPokemon;
}

List<PokemonResponse> pokemonResponseFromJson(String str){
  return List<PokemonResponse>.from(json.decode(str).map((x) => {
    PokemonResponse.fromJson(x)
  }));

}
class PokemonResponse{

  PokemonResponse({required this.count, required this.next, required this.previous, required this.results});

  int count;
  String next;
  String previous;
  List<Pokemon> results;

  factory PokemonResponse.fromJson(Map<String, dynamic> json) => PokemonResponse(
      count: json["count"] as int,
      next: json["next"] as String,
      previous: json["previous"] as String,
      results: pokemonListFromList(json["results"]),
    );

}