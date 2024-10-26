import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../modelos/lista_listas_compra.dart';

class Util{
  final List<Color> _colores = [Colors.red, Colors.green, Colors.blue, Colors.pinkAccent, Colors.amber, Colors.deepPurpleAccent];
  Util._();

  static final Util instance = Util._();

  Future<void> guardarDatos(ListaListasCompra l) async {
    final directorio = await getApplicationDocumentsDirectory();
    final archivo = File('${directorio.path}/lista_compra.json');
    await archivo.writeAsString(l.toJsonString());
  }

  Color getRandomColor(){
      final random = Random();
      return _colores.elementAt(random.nextInt(_colores.length));
    }

  Color darken(Color color, [double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }
}