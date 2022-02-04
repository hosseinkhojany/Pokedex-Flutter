import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:untitled1/controller/pokemonContoller.dart';
import 'package:untitled1/data/model/pokemon.dart';
import 'package:untitled1/utils/consts.dart';
import 'package:untitled1/utils/paletteUtil.dart';

import '../../data/model/pokemonInfo.dart';

// ignore: must_be_immutable
class PokemonDetail extends StatelessWidget {
  final Pokemon pokemon;
  PokemonController _controller = Get.find();

  PokemonDetail({required this.pokemon, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    bool useVerticalLayout = screenSize.width < screenSize.height;
    bool hideDetailPanel = screenSize.shortestSide < 250;
    _controller.loadPokemonInfo(pokemon.name);
    return Scaffold(
      appBar: hideDetailPanel
          ? AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.grey.shade300,
        centerTitle: true,
        title: Text(pokemon.name),
        titleTextStyle: TextStyle(
          color: Colors.black,
        ),
      )
          : null,
      body: SafeArea(
        child: Flex(
          direction: useVerticalLayout ? Axis.vertical : Axis.horizontal,
          children: [
            if (hideDetailPanel == false) ...[
              Flexible(
                child: Card(
                    margin: EdgeInsets.zero,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: useVerticalLayout
                            ? Radius.circular(50)
                            : Radius.circular(0),
                        bottomRight: Radius.circular(50),
                        topLeft: useVerticalLayout
                            ? Radius.circular(0)
                            : Radius.circular(0),
                        topRight: useVerticalLayout
                            ? Radius.circular(0)
                            : Radius.circular(50),
                      ),
                    ),
                    shadowColor: Colors.deepOrangeAccent,
                    child:
                    FutureBuilder<PaletteGenerator>(
                      future: PaletteUtil.updatePaletteGenerator(pokemon.getImage()), // async work
                      builder: (BuildContext context, AsyncSnapshot<PaletteGenerator> snapshot) {
                        Color pokemonColor = Color(pokemon.color);
                        if(snapshot.data?.dominantColor?.color != null){
                          pokemonColor = snapshot.data!.dominantColor!.color;
                          if(pokemon.color == Colors.black12.value){
                            _controller.updatePokemonColor(pokemon.page, pokemon.name, snapshot.data!.dominantColor!.color.value);
                          }
                        }
                        return
                          Container(
                            color: pokemonColor,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.center,
                                    color: Colors.black12,
                                    child: Stack(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(left: 15),
                                            child: IconButton(
                                              tooltip: "back",
                                              icon: Icon(Icons.arrow_back_rounded),
                                              onPressed: () => {
                                                Navigator.pop(context),
                                              },
                                            ),
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            pokemon.name,
                                            style: TextStyle(
                                              fontSize: 30.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 5,
                                  child: Container(
                                    alignment: Alignment.center,
                                    color: Colors.black12,
                                    child: CachedNetworkImage(
                                      imageUrl: pokemon.getImage(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                      },
                    )
                ),
              ),
            ],
            Flexible(
              child: Obx(
                    () {
                  PokemonInfo pokemonInfo = _controller.currentPokemonInfo;
                  switch (_controller.requestStateAPokemon.value) {
                    case RequestState.LOADING:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    case RequestState.ERROR:
                      return Center(
                        child: IconButton(
                          tooltip: "retry",
                          icon: Icon(Icons.refresh_outlined),
                          onPressed: () => {
                            _controller.loadPokemonInfo(pokemon.name, true),
                          },
                        ),
                      );
                    default:
                      return Center(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth:
                          useVerticalLayout ? screenSize.width * 0.80 : screenSize.width * 0.40
                          ),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      for (var i in pokemonInfo.types)
                                        Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                          clipBehavior: Clip.antiAlias,
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Text(i),
                                          ),
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: 25.0),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            (pokemonInfo.weight / 10)
                                                .toString() +
                                                " KG",
                                            style: new TextStyle(
                                              fontSize: 25.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: 10.0),
                                          Text("Weight"),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            (pokemonInfo.height / 10)
                                                .toString() +
                                                " M",
                                            style: TextStyle(
                                              fontSize: 25.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(height: 10.0),
                                          Text("Height"),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(height: 25.0),
                                      Text(
                                        "Base Stats",
                                        style: new TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 15.0),
                                      ability("HP", pokemonInfo.hp),
                                      SizedBox(height: 10.0),
                                      ability("ATK", pokemonInfo.attack),
                                      SizedBox(height: 10.0),
                                      ability("DEF", pokemonInfo.defense),
                                      SizedBox(height: 10.0),
                                      ability("SPD", pokemonInfo.speed),
                                      SizedBox(height: 10.0),
                                      ability("EXP", pokemonInfo.exp, 1000)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget ability(String abilityName, int abilityValue, [int maxAbilityValue = 300]) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Center(
            child: Text(
              abilityName,
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
          ),
          flex: 1,
        ),
        Expanded(
          child: Container(
            height: 25,
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  GFProgressBar(
                      lineHeight: 25,
                      percentage: abilityValue / maxAbilityValue,
                      backgroundColor: Colors.black26,
                      progressBarColor: GFColors.DANGER),
                  Align(
                    alignment: Alignment.center,
                    child: Text(maxAbilityValue.toString()+"/" + abilityValue.toString()),
                  ),
                ],
              ),
            ),
          ),
          flex: 5,
        ),
      ],
    );
  }
}
