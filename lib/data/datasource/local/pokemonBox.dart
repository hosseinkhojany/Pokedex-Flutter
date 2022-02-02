import 'package:hive/hive.dart';
import 'package:untitled1/data/config/hive/hiveConfig.dart';
import 'package:untitled1/data/model/pokemon.dart';
import 'package:untitled1/data/model/pokemonInfo.dart';

class PokemonBox{

  static String _boxKey(int page){
    return POKEMON_BOX+page.toString();
  }

  static Future<bool> insertListPokemon(List<Pokemon> data, int page) async {
    try{
      final box = await Hive.openBox(_boxKey(page));
      data.forEach((element) {
        box.put(element.name, element);
      });
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }

  static Future<List<Pokemon>> getListPokemon(int page) async {
    try{
      List<Pokemon> result = [];
      final box = await Hive.openBox(_boxKey(page));
      box.keys.forEach((element) {
        result.add(box.get(element));
      });
      return result;
    }catch(e){
      print(e);
      return [];
    }
  }

  static Future<bool> insertPokemonInfo(PokemonInfo pokemonInfo) async {
    try{
      final box = await Hive.openBox<PokemonInfo>(pokemonInfo.name);
      box.put(pokemonInfo.name, pokemonInfo);
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }

  static Future<PokemonInfo?> getPokemonInfo(String pokemonName) async{
    try{
      final box = await Hive.openBox<PokemonInfo>(pokemonName);
      return box.get(pokemonName);
    }catch(e){
      print(e);
      return null;
    }
  }

  static Future<bool> updatePokemonColor(int page, String pokemonName, int color) async{
    try{
      final box = await Hive.openBox(_boxKey(page));
      Pokemon? pokemon = box.get(pokemonName);
      pokemon!.color = color;
      box.put(pokemonName, pokemon);
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }

}