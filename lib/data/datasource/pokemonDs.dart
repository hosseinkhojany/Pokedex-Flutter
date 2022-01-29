import 'package:dio/dio.dart';
import 'package:untitled1/data/model/pokemonResponse.dart';
import '../config/paginationFilter.dart';

class PokemonDs{

  final Dio _dio;

  PokemonDs(this._dio);

  Future fetchNewListPokemon(PaginationFilter filter) async {
    try{
      var response = await _dio.get('/pokemon', queryParameters: {
        'limit': filter.limit,
        'offset': filter.page
      });
      if (response.statusCode == 200) {
        return PokemonResponse.fromJson(response.data);
      } else {
        return [];
      }
    }catch(e){
      return [];
    }

  }

}