import 'package:flutter/material.dart';
import 'package:untitled1/data/config/paginationFilter.dart';
import 'package:untitled1/data/datasource/pokemonDs.dart';
import 'package:untitled1/data/model/pokemonResponse.dart';

class PokemonRepository{

    final PokemonDs pokemonDs;

    PokemonRepository(this.pokemonDs);

    Future<void> getNewListPokemon(
        PaginationFilter filter,
        {Function? start = null,
            Function? complete = null,
            Function? error = null,
            Function? success = null}
        ) async{
        start?.call();
        try {
            var listPokemon = await pokemonDs.fetchNewListPokemon(filter);
            if (listPokemon != null) {
                success?.call(listPokemon);
            }
        } catch(e) {
            error?.call();
        } finally {
            complete?.call();
        }
    }

    // Future<PokemonResponse?> getNewListPokemon(PaginationFilter filter) async{
    //     try {
    //         var listPokemon = await pokemonDs.fetchNewListPokemon(filter);
    //         if (listPokemon != null) {
    //             return listPokemon;
    //         }
    //     } catch(e) {
    //     }
    //     return null;
    // }


}