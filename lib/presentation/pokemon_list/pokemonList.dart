import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:untitled1/appRouter.dart';
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
        title: Text("Flutter GridView Demo"),
      ),
      body: Obx(
        () => LazyLoadScrollView(
          onEndOfPage: _controller.loadNextPage,
          isLoading: _controller.lastPage,
          child: GridView.count(
            padding: const EdgeInsets.all(10),
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            children: List.generate(
              _controller.pokemons.length,
              (index) {
                final pokemon = _controller.pokemons[index];
                return Card(
                  child: SizedBox(
                    width: screenSize.width,
                    height: 150,
                    child: OpenContainer<bool>(
                      tappable: false,
                      transitionType: ContainerTransitionType.fade,
                      closedShape: const RoundedRectangleBorder(),
                      closedElevation: 0,
                      openBuilder: (context, openContainer) =>
                          const PokemonDetail(),
                      closedBuilder: (context, openContainer) {
                        return InkWell(
                          onTap: ()=> openContainer.call(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.black38,
                                height: 150,
                                child: Center(
                                  child: Image.network(
                                    pokemon.getImage(),
                                    width: 90,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(pokemon.name),
                                    ],
                                  ),
                                ),
                              ),
                            ],
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

class _DetailsPage extends StatelessWidget {
  const _DetailsPage();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("hello"),
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.black38,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(70),
              child: Image.asset(
                'placeholders/placeholder_image.png',
                package: 'flutter_gallery_assets',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "hello",
                  style: textTheme.headline5?.copyWith(
                    color: Colors.black54,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Hello",
                  style: textTheme.bodyText2?.copyWith(
                    color: Colors.black54,
                    height: 1.5,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
