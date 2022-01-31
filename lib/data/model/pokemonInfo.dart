import 'dart:math';

List<String> typesFromJson(List<dynamic> str) {
  List<String> result = [];
  str.forEach((element) {
    result.add((((element as Map<String, dynamic>)['type']) as Map<String, dynamic>)['name'] ?? "");
  });
  return result;
}

class PokemonInfo {
  PokemonInfo(
      {required this.id,
      required this.name,
      required this.height,
      required this.weight,
      required this.base_experience,
      required this.types});

  int id;
  String name;
  int height;
  int weight;
  int base_experience;
  List<String> types;
  int hp = Random.secure().nextInt(300);
  int attack = Random.secure().nextInt(300);
  int defense = Random.secure().nextInt(300);
  int speed = Random.secure().nextInt(300);
  int exp = Random.secure().nextInt(1000);

  factory PokemonInfo.fromJson(Map<String, dynamic> json) => PokemonInfo(
        id: json["id"],
        name: json["name"],
        height: json["height"],
        weight: json["weight"],
        base_experience: json["base_experience"],
        types: typesFromJson(json["types"]),
      );

// @JsonClass(generateAdapter = true)
// data class TypeResponse(
// @field:Json(name = "slot") val slot: Int,
// @field:Json(name = "type") val type: Type
// )
//
// @JsonClass(generateAdapter = true)
// data class Type(
// @field:Json(name = "name") val name: String
// )

}
