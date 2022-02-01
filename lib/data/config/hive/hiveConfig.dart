import 'package:hive_flutter/hive_flutter.dart';

const POKEMON_BOX = "POKEMON_BOX";

class HiveConfig {
  HiveConfig() {
    Hive.initFlutter();
  }
}
