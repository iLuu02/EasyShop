import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'dart:io';
import 'package:path_provider/path_provider.dart';


import 'package:proyecto_moviles/componentes/easy_shop_tema.dart';
import 'package:proyecto_moviles/modelos/lista_listas_compra.dart';
import 'package:proyecto_moviles/pantallas/PaginaPrincipalPantalla/pagina_principal_pantalla.dart';

class EasyShop extends StatelessWidget {
  const EasyShop({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyShop',

      theme: EasyShopTema.claro(), //tema del modo claro
      darkTheme: EasyShopTema.oscuro(), //tema del modo oscuro
      themeMode: ThemeMode.system,

      home: FutureBuilder<ListaListasCompra>(
        future: _leerListaListasCompra(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider.value(value: snapshot.data!),
              ],

              child: PaginaPrincipalPantalla(),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }

  Future<ListaListasCompra> _leerListaListasCompra() async {
    final directorio = await getApplicationDocumentsDirectory();
    final archivo = File('${directorio.path}/lista_compra.json');
    if (await archivo.exists()) {
      final jsonString = await archivo.readAsString();
      return ListaListasCompra.fromJsonString(jsonString);
    } else {
      return ListaListasCompra();
    }
  }
}