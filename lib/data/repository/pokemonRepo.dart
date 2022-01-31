import 'package:untitled1/data/config/paginationFilter.dart';
import 'package:untitled1/data/datasource/pokemonDs.dart';
import 'package:untitled1/data/model/errorResponse.dart';

class PokemonRepository {
  final PokemonDs pokemonDs;

  PokemonRepository(this.pokemonDs);

  Future<void> getNewListPokemon(PaginationFilter filter,
      {required Function start,
        required Function error,
        required Function success}) async {
    start.call();
    try {
      var response = await pokemonDs.fetchNewListPokemon(filter);
      if (response != null) {
        success.call(response);
      } else {
        error.call((response as ErrorResponse).message);
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
      var response = await pokemonDs.fetchAPokemonInfo(name);
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
