import 'package:hive_flutter/hive_flutter.dart';
import 'package:untitled1/data/model/pokemon.dart';
import 'package:untitled1/data/model/pokemonInfo.dart';

const POKEMON_BOX = "POKEMON_BOX";
const SHARED_STORE = "SHARED_STORE";

class HiveConfig {
  static Future<void> init() async {
    await Hive.initFlutter();
    _registerAdapter();
    await _unBoxing();
  }
  //remove future for testing
  static Future<void> _unBoxing() async {
    await Hive.openBox(SHARED_STORE);
  }
  static void _registerAdapter(){
    Hive.registerAdapter(PokemonAdapter());
    Hive.registerAdapter(PokemonInfoAdapter());
  }
}
