import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled1/presentation/login/sginUp.dart';
import 'package:untitled1/presentation/login/signIn.dart';
import 'package:untitled1/presentation/pokemon_list/pokemonList.dart';
import 'package:untitled1/presentation/splash/splash.dart';

const String SPLASH_ROUTE = "/";
const String LOGIN_SIGNIN_ROUTE = "/signin";
const String LOGIN_SIGNUP_ROUTE = "/signup";
const String POKEMON_LIST_ROUTE = "/pokemons_list";
const String POKEMON_DETAIL_ROUTE = "/pokemon_detail";

class AppRouter {
  SharedAxisTransition globalTransaction(
      context, animation, secondaryAnimation, child) {
    return SharedAxisTransition(
      fillColor: Colors.black,
      transitionType: SharedAxisTransitionType.scaled,
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      child: child,
    );
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case SPLASH_ROUTE:
        // return PageTransition(child: SplashScreen(), type: PUSH_ANIMATION);
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return SplashScreen();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return globalTransaction(
                context, animation, secondaryAnimation, child);
          },
        );
      case LOGIN_SIGNUP_ROUTE:
        // return PageTransition(child: SignUpScreen(), type: PUSH_ANIMATION);
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return SignUpScreen();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return globalTransaction(
                context, animation, secondaryAnimation, child);
          },
        );
      case LOGIN_SIGNIN_ROUTE:
        // return PageTransition(child: SignInScreen(), type: PUSH_ANIMATION);
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return SignInScreen();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return globalTransaction(
                context, animation, secondaryAnimation, child);
          },
        );
      case POKEMON_LIST_ROUTE:
        // return PageTransition(child: PokemonListScreen(Get.find()), type: PUSH_ANIMATION);
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return PokemonListScreen(Get.find());
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return globalTransaction(
                context, animation, secondaryAnimation, child);
          },
        );
      default:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return SplashScreen();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return globalTransaction(
                context, animation, secondaryAnimation, child);
          },
        );
    }
  }
}
