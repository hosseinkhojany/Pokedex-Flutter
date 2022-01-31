import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      body: Flex(
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
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.grey.shade300,
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
                        color: Colors.grey.shade300,
                        child: Image.network(
                          pokemon.getImage(),
                        ),
                      ),
                    ),
                  ],
                ),
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          (pokemonInfo.weight / 10).toString() +
                                              " KG",
                                          style: new TextStyle(
                                            fontSize: 25.0,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text("Weight"),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          (pokemonInfo.height / 10).toString() +
                                              " M",
                                          style: new TextStyle(
                                            fontSize: 25.0,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text("Height"),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text("Base Stats"),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Text("HP"),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 10,
                                            child: Card(color: Colors.red),
                                          ),
                                          flex: 5,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Text("HP"),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 10,
                                            child: Card(color: Colors.red),
                                          ),
                                          flex: 5,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Text("HP"),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 10,
                                            child: Card(color: Colors.red),
                                          ),
                                          flex: 5,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Text("HP"),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 10,
                                            child: Card(color: Colors.red),
                                          ),
                                          flex: 5,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                          child: Text("HP"),
                                          flex: 1,
                                        ),
                                        Expanded(
                                          child: Container(
                                            height: 10,
                                            child: Card(color: Colors.red),
                                          ),
                                          flex: 5,
                                        ),
                                      ],
                                    ),
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
    );
  }
}
