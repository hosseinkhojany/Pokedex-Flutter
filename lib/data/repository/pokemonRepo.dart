import 'package:untitled1/data/config/paginationFilter.dart';
import 'package:untitled1/data/datasource/local/pokemonBox.dart';
import 'package:untitled1/data/datasource/remote/pokemonDs.dart';
import 'package:untitled1/data/model/errorResponse.dart';
import 'package:untitled1/data/model/pokemonResponse.dart';

class PokemonRepository {
  final PokemonDs pokemonDs;

  PokemonRepository(this.pokemonDs);

  Future<void> getNewListPokemon(PaginationFilter filter,
      {required Function start,
        required Function error,
        required Function success}) async {
    start.call();
    try {
      var localData = await PokemonBox.getListPokemon(filter.page);
      if(localData.isEmpty){
        PokemonResponse? response = await pokemonDs.fetchNewListPokemon(filter);
        if ((response is ErrorResponse == false) && response != null) {
          success.call(response.results);
          PokemonBox.insertListPokemon(response.results, filter.page);
        } else {
          error.call((response as ErrorResponse).message);
        }
      }else{
        success.call(localData);
      }
    } catch (e) {
      error.call("try again");
    }
  }

  Future<void> getAPokemonInfo(String name,
      {required Function start,
      required Function error,
      required Function success}) async {
    start.call();
    try {
      var localData = await PokemonBox.getPokemonInfo(name);
      if(localData == null){
        var response = await pokemonDs.fetchAPokemonInfo(name);
        if ((response is ErrorResponse) == false) {
          success.call(response);
          PokemonBox.insertPokemonInfo(response);
        } else {
          error.call((response as ErrorResponse).message);
        }
      }else{
        success.call(localData);
      }
    } catch (e) {
      error.call("try again");
    }
  }

  Future<void> updatePokemonColor(
      int page,
      String pokemonName,
      int color,
      {required Function start,
      required Function error,
      required Function success}) async {
    start.call();
    try {
        var response = await PokemonBox.updatePokemonColor(page, pokemonName, color);
        if ((response is ErrorResponse) == false) {
          success.call(response);
        } else {
          error.call((response as ErrorResponse).message);
        }
    } catch (e) {
      error.call("try again");
    }
  }
}
