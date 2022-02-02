import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:flutter/cupertino.dart';

class PaletteUtil {

  static Future<PaletteGenerator> updatePaletteGenerator(String imageUrl) async {
    var paletteGenerator = await PaletteGenerator.fromImageProvider(
      Image.file(await DefaultCacheManager().getSingleFile(imageUrl)).image,
    );
    return paletteGenerator;
  }

    // FutureBuilder<PaletteGenerator>(
    //   future: _updatePaletteGenerator(imageUrl), // async work
    //   builder: (BuildContext context, AsyncSnapshot<PaletteGenerator> snapshot) {
    //     if(snapshot.data?.dominantColor?.color == true){
    //       return Container(color: snapshot.data?.dominantColor?.color,);
    //     }else{
    //       return Container(color: snapshot.data?.dominantColor?.color,);
    //     }
    //   },
    // );

}
