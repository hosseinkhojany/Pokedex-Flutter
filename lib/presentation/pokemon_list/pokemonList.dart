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
            child: ListView.builder(
              itemCount: _controller.pokemons.length,
              itemBuilder: (context, index) {
                final pokemon = _controller.pokemons[index];
                return SizedBox(
                  width: screenSize.width,
                  height: 200,
                  child: OpenContainer<bool>(
                      tappable: false,
                      transitionType: ContainerTransitionType.fade,
                      closedShape: const RoundedRectangleBorder(),
                      closedElevation: 0,
                      openBuilder: (context, openContainer) =>
                          const PokemonDetail(),
                      closedBuilder: (context, openContainer) {
                        return Card(
                          color: Colors.orange,
                          child: Center(
                              child: InkWell(
                            onTap: () => {
                              openContainer.call()
                            },
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(
                                    height: 90,
                                    width: 90,
                                    child: Image.network(
                                      pokemon.getImage(),
                                    ),
                                  ),
                                  Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(pokemon.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!)),
                                ]),
                          )),
                        );
                      }),
                );
              },
            ),
          ),
        ));
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
