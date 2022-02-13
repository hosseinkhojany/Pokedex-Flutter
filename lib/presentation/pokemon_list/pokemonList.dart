import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'package:untitled1/controller/pokemonContoller.dart';
import 'package:untitled1/data/model/pokemon.dart';
import 'package:untitled1/presentation/pokemon_detail/pokemonDetail.dart';
import 'package:untitled1/utils/consts.dart';
import 'package:untitled1/utils/paletteUtil.dart';
import 'package:untitled1/utils/theme_util.dart';

class PokemonListScreen extends StatefulWidget {
  final PokemonController _controller;

  const PokemonListScreen(this._controller, {Key? key}) : super(key: key);

  @override
  State<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  var _enableDarkTheme = true;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _enableDarkTheme = (themeNotifier.getTheme() == darkTheme);

    return Scaffold(
      backgroundColor: themeData.colorScheme.background,
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(5),
          child: Image.asset("assets/images/ic_icon.png"),
        ),
        title: Text("Pokedex Flutter"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: SizedBox(
              width: 60,
              child: DayNightSwitcher(
                isDarkModeEnabled: _enableDarkTheme,
                sunColor: Colors.yellow,
                onStateChanged: (val) {
                  debugPrint('onStateChanged: $val');
                  setState(() {
                    _enableDarkTheme = val;
                  });
                  onThemeChanged(val, themeNotifier);
                },
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () {
          switch (widget._controller.requestStateListPokmemon.value) {
            case RequestState.LOADING:
              if (widget._controller.pokemons.length > 0) {
                WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: SizedBox(
                        height: 20,
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
              if (widget._controller.pokemons.length > 0) {
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
                                onPressed: () =>
                                    {widget._controller.loadNextPage()},
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
                      widget._controller.loadNextPage(true),
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

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(darkTheme)
        : themeNotifier.setTheme(lightTheme);
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', value);
  }

  Widget _mainContent() {
    return LazyLoadScrollView(
      onEndOfPage: widget._controller.loadNextPage,
      isLoading: widget._controller.lastPage,
      child:
       ResponsiveGridList(
        horizontalGridMargin: 10,
        verticalGridMargin: 10,
        minItemWidth: 150,
        children: List.generate(
          widget._controller.pokemons.length,
          (index) {
            final pokemon = widget._controller.pokemons[index];
            
            return FutureBuilder<PaletteGenerator>(
              future: PaletteUtil.updatePaletteGenerator(pokemon.getImage()),
              builder: (context, snapshot) {
                if (pokemon.color != Colors.black12.value) {
                  return _PokemonItem(
                      pokemon: pokemon, dominantColor: Color(pokemon.color));
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return SizedBox();
                } else {
                  PokemonController _controller = Get.find();
                  var dominantColor =
                      (snapshot.data as PaletteGenerator).dominantColor!.color;
                  _controller.updatePokemonColor(
                      pokemon.page, pokemon.name, dominantColor.value);
                  return _PokemonItem(
                      pokemon: pokemon, dominantColor: dominantColor);
                }
              },
            );
          },
        ),
      ),
    );
  }
}

class _PokemonItem extends StatelessWidget {
  const _PokemonItem({
    Key? key,
    required this.pokemon,
    required this.dominantColor,
  }) : super(key: key);

  final Pokemon pokemon;
  final Color dominantColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: 160,
            height: 210,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Color(pokemon.color).withOpacity(0.6),
                blurRadius: 15,
              )
            ])),
        Card(
          color: Colors.black12,
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            width: 150,
            height: 200,
            child: OpenContainer<bool>(
              tappable: false,
              transitionType: ContainerTransitionType.fade,
              closedShape: const RoundedRectangleBorder(),
              closedElevation: 0,
              openBuilder: (context, openContainer) =>
                  PokemonDetail(pokemon: pokemon),
              closedBuilder: (context, openContainer) {
                return InkWell(
                  onTap: () => openContainer.call(),
                  child: Container(
                    color: dominantColor.withOpacity(0.7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 150,
                          child: Center(
                            child: CachedNetworkImage(
                              imageUrl: pokemon.getImage(),
                              width: 90,
                              placeholder: (context, url) {
                                return Center(
                                  child: SkeletonGridLoader(
                                    builder: SingleChildScrollView(
                                      child: GridTile(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Image.asset(
                                                "assets/images/pokemon.png"),
                                          ],
                                        ),
                                      ),
                                    ),
                                    items: 1,
                                    itemsPerRow: 1,
                                    period: Duration(milliseconds: 2500),
                                    baseColor:
                                        Color(pokemon.color).withOpacity(0.1),
                                    highlightColor: Colors.black26,
                                    direction: SkeletonDirection.ltr,
                                    childAspectRatio: 1,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 150,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 10,
                                          spreadRadius: 15,
                                          color: Color(pokemon.color)
                                              .withOpacity(0.4)),
                                    ],
                                  ),
                                  child: Text(
                                    pokemon.name,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Color(0xff293241),
                                    ),
                                  ),
                                ),
                              ],
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
        ),
      ],
    );
  }
}
