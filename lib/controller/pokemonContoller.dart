import 'package:get/get.dart';
import 'package:untitled1/data/model/pokemon.dart';
import 'package:untitled1/data/model/pokemonResponse.dart';
import 'package:untitled1/data/repository/pokemonRepo.dart';

import '../data/config/paginationFilter.dart';

class PokemonController extends GetxController {

  final PokemonRepository _pokemonRepository;
  final _pokemons = <Pokemon>[].obs;
  final _paginationFilter = PaginationFilter().obs;
  final _lastPage = false.obs;

  PokemonController(this._pokemonRepository);

  var isLoading = true.obs;
  List<Pokemon> get pokemons => _pokemons.toList();
  int get limit => _paginationFilter.value.limit;
  int get _page => _paginationFilter.value.page;
  bool get lastPage => _lastPage.value;

  @override
  void onInit() {
    ever(_paginationFilter, (_) => _getNewPokemon());
    _changePaginationFilter(1, 25);
    super.onInit();
  }

  Future<void> _getNewPokemon() async {
    await _pokemonRepository.getNewListPokemon(
      _paginationFilter.value,
          start: () => { isLoading.value = true },
          complete: () => { isLoading.value = false },
          error: () => {  },
          success: (pokemonResponse) => {
          if ((pokemonResponse as PokemonResponse).results.isNotEmpty) {
            _pokemons.addAll(pokemonResponse.results)
          }else{
            _lastPage.value = true
          }
      },);
  }

  // Future<void> _getNewPokemon() async {
  //   PokemonResponse? response = await _pokemonRepository.getNewListPokemon(_paginationFilter.value);
  //   if(response != null){
  //     if(response.results.isNotEmpty){
  //       _pokemons.addAll(response.results);
  //     }else{
  //       _lastPage.value = true;
  //     }
  //   }
  // }
  void changeTotalPerPage(int limitValue) {
    _pokemons.clear();
    _lastPage.value = false;
    _changePaginationFilter(1, limitValue);
  }
  void _changePaginationFilter(int page, int limit) {
    _paginationFilter.update((val) {
      val?.page = page;
      val?.limit = limit;
    });
  }
  void loadNextPage() => _changePaginationFilter(_page + 1, limit);

}