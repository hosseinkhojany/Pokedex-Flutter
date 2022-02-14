import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:untitled1/controller/pokemonContoller.dart';
import 'package:untitled1/data/model/pokemon.dart';
import 'package:untitled1/utils/consts.dart';

import '../../data/model/pokemonInfo.dart';

// ignore: must_be_immutable
class PokemonDetail extends StatelessWidget {
  final Pokemon pokemon;
  PokemonController _controller = Get.find();

  PokemonDetail({required this.pokemon, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    Size screenSize = MediaQuery.of(context).size;
    bool useVerticalLayout = screenSize.width < screenSize.height;
    bool hideDetailPanel = screenSize.shortestSide < 250;
    _controller.loadPokemonInfo(pokemon.name);
    return Scaffold(
      backgroundColor: themeData.colorScheme.background,
      appBar: hideDetailPanel
          ? AppBar(
              iconTheme: IconThemeData(color: Colors.black),
              shadowColor: Colors.transparent,
              backgroundColor: Colors.grey.shade300,
              centerTitle: true,
              title: Text(
                pokemon.name,
              ),
              titleTextStyle: TextStyle(
                color: themeData.primaryColor,
              ),
            )
          : null,
      body: SafeArea(
        child: Flex(
          direction: useVerticalLayout ? Axis.vertical : Axis.horizontal,
          children: [
            if (hideDetailPanel == false) ...[
              Flexible(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Color(pokemon.color),
                            blurRadius: 20,
                            offset: Offset(0.0, 1))
                      ]),
                    ),
                    Card(
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
                      shadowColor: Theme.of(context).colorScheme.primary,
                      child: Container(
                        color: Color(pokemon.color).withOpacity(0.6),
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
                                          icon: Icon(
                                            Icons.arrow_back_rounded,
                                          ),
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
                      ),
                    ),
                  ],
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
                          constraints: BoxConstraints(maxWidth: 450),
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
                                            "${pokemonInfo.weight / 10} KG",
                                            style: new TextStyle(
                                              fontSize: 25.0,
                                              color:
                                                  themeData.colorScheme.primary,
                                            ),
                                          ),
                                          SizedBox(height: 10.0),
                                          Text(
                                            "Weight",
                                            style: TextStyle(
                                                color: themeData
                                                    .colorScheme.primary),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "${pokemonInfo.height / 10} M",
                                            style: TextStyle(
                                              fontSize: 25.0,
                                              color:
                                                  themeData.colorScheme.primary,
                                            ),
                                          ),
                                          SizedBox(height: 10.0),
                                          Text(
                                            "Height",
                                            style: TextStyle(
                                                color: themeData
                                                    .colorScheme.primary),
                                          ),
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
                                          color: themeData.colorScheme.primary,
                                        ),
                                      ),
                                      SizedBox(height: 15.0),
                                      ability(context, "HP", pokemonInfo.hp),
                                      SizedBox(height: 10.0),
                                      ability(
                                          context, "ATK", pokemonInfo.attack),
                                      SizedBox(height: 10.0),
                                      ability(
                                          context, "DEF", pokemonInfo.defense),
                                      SizedBox(height: 10.0),
                                      ability(
                                          context, "SPD", pokemonInfo.speed),
                                      SizedBox(height: 10.0),
                                      ability(
                                          context, "EXP", pokemonInfo.exp, 1000)
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

  Widget ability(BuildContext context, String abilityName, int abilityValue,
      [int maxAbilityValue = 300]) {
    final themeData = Theme.of(context);
    final percentage = abilityValue / maxAbilityValue;
    Color color;
    if (percentage <= 0.4) {
      color = GFColors.DANGER;
    } else if (percentage <= 0.75) {
      color = GFColors.WARNING;
    } else {
      color = GFColors.SUCCESS;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Center(
            child: Text(
              abilityName,
              style: TextStyle(
                fontSize: 18.0,
                color: themeData.colorScheme.primary,
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
                      progressBarColor: color),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      '$maxAbilityValue / $abilityValue',
                      style: TextStyle(
                        color: themeData.colorScheme.primary,
                      ),
                    ),
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
