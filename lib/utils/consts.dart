import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF3D5A80);
const kPrimaryLightColor = Color(0x98C1D9);
// https://pokeapi.co/api/v2/pokemon
const BASE_API_URL = "https://pokeapi.co/api/v2";
// constant for page limit & timeout
mixin AppLimit {
  static const int DIO_TIME_OUT = 30000;
}
enum RequestState{
  LOADING,
  IDLE,
  ERROR,
  SUCCESS
}

const String appVersion = '0.0.1';
const String environment = 'Production';
