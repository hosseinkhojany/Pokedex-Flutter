import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:untitled1/controller/pokemonContoller.dart';
import 'package:untitled1/presentation/pokemon_detail/pokemonDetail.dart';
import 'package:untitled1/utils/consts.dart';

class PokemonListScreen extends StatelessWidget {
  final PokemonController _controller;

  const PokemonListScreen(this._controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    int crossAxisCount = (screenSize.width / 200).round();
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(5),
          child: Image.asset("assets/images/ic_icon.png"),
        ),
        title: Text("Pokedex Flutter"),
      ),
      body: Obx(
        () {
          switch (_controller.requestStateListPokmemon.value) {
            case RequestState.LOADING:
              if (_controller.pokemons.length > 0) {
                WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: SizedBox(
                        height: 40,
                        child: Center(
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text("Loading..."),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: CircularProgressIndicator(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
                return _mainContent();
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            case RequestState.ERROR:
              if (_controller.pokemons.length > 0) {
                WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: SizedBox(
                        height: 40,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text("failed to load more pokemons"),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                onPressed: () => {_controller.loadNextPage()},
                                icon: Icon(
                                  Icons.refresh_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
                return _mainContent();
              } else {
                return Center(
                  child: IconButton(
                    tooltip: "retry",
                    icon: Icon(Icons.refresh_outlined),
                    onPressed: () => {
                      _controller.loadNextPage(true),
                    },
                  ),
                );
              }

            default:
              return _mainContent();
          }
        },
      ),
    );
  }

  Widget _mainContent() {
    return LazyLoadScrollView(
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
              color: Colors.black12,
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
                        color: pokemon.color == 0
                            ? Colors.black12
                            : Color(pokemon.color),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 150,
                              child: Center(
                                child: CachedNetworkImage(
                                  imageUrl: pokemon.getImage(),
                                  width: 90,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        pokemon.name,
                                        style: TextStyle(fontSize: 18),
                                      ),
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
    );
  }
}
