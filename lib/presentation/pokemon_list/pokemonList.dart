import 'dart:ui';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:untitled1/controller/pokemonContoller.dart';
import 'package:untitled1/presentation/pokemon_detail/pokemonDetail.dart';

class PokemonListScreen extends StatelessWidget {
  final PokemonController _controller;

  const PokemonListScreen(this._controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    int crossAxisCount = (screenSize.width / 200).round();
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex Flutter"),
      ),
      body: Obx(
        () => LazyLoadScrollView(
          onEndOfPage: _controller.loadNextPage,
          isLoading: _controller.lastPage,
          child: ResponsiveGridList(
            horizontalGridMargin: 10,
            verticalGridMargin: 10,
            minItemWidth: 150,
            children: List.generate(
              _controller.pokemons.length,
              (index) {
                final pokemon = _controller.pokemons[index];
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  clipBehavior: Clip.antiAlias,
                  elevation: 5,
                  child: SizedBox(
                    width: 150,
                    height: 200,
                    child: OpenContainer<bool>(
                      tappable: false,
                      transitionType: ContainerTransitionType.fade,
                      closedShape: const RoundedRectangleBorder(),
                      closedElevation: 0,
                      openBuilder: (context, openContainer) => PokemonDetail(
                        pokemon: pokemon,
                      ),
                      closedBuilder: (context, openContainer) {
                        return InkWell(
                          onTap: () => openContainer.call(),
                          child: Container(
                            color: Colors.black12,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 150,
                                  child: Center(
                                    child: Image.network(
                                      pokemon.getImage(),
                                      width: 90,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(pokemon.name),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
