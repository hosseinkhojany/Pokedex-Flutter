import 'dart:math';
import 'package:hive/hive.dart';

List<String> typesFromJson(List<dynamic> str) {
  List<String> result = [];
  str.forEach((element) {
    result.add((((element as Map<String, dynamic>)['type']) as Map<String, dynamic>)['name'] ?? "");
  });
  return result;
}
@HiveType(typeId: 2, adapterName: "PokemonInfoTypeConverter")
class PokemonInfo extends HiveObject {
  PokemonInfo(
  this.id,
  this.name,
  this.height,
  this.weight,
  this.base_experience,
  this.types, {
        this.hp = 0,
        this.attack = 0,
        this.defense = 0,
        this.speed = 0,
        this.exp = 0,
      });

  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  int height;
  @HiveField(3)
  int weight;
  @HiveField(4)
  int base_experience;
  @HiveField(5)
  List<String> types;
  @HiveField(6)
  int hp = Random.secure().nextInt(300);
  @HiveField(7)
  int attack = Random.secure().nextInt(300);
  @HiveField(8)
  int defense = Random.secure().nextInt(300);
  @HiveField(9)
  int speed = Random.secure().nextInt(300);
  @HiveField(10)
  int exp = Random.secure().nextInt(1000);

  factory PokemonInfo.fromJson(Map<String, dynamic> json) => PokemonInfo(
        json["id"],
        json["name"],
        json["height"],
        json["weight"],
        json["base_experience"],
        typesFromJson(json["types"]),
      );

}
