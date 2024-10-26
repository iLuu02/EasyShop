import 'package:flutter/material.dart';
import 'package:proyecto_moviles/componentes/lista_compra_header.dart';
import 'package:proyecto_moviles/modelos/lista_listas_compra.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_moviles/pantallas/PaginaPrincipalPantalla/pagina_principal_anadir_lista.dart';
import 'package:proyecto_moviles/pantallas/PaginaPrincipalPantalla/pagina_principal_pantalla_llena.dart';
import 'package:proyecto_moviles/pantallas/PaginaPrincipalPantalla/pagina_principal_pantalla_vacia.dart';
import '../../util/util.dart';

class PaginaPrincipalPantalla extends StatelessWidget {
  const PaginaPrincipalPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Util.instance.getRandomColor();

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      key: GlobalKey<ScaffoldState>(),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      extendBodyBehindAppBar: true,

      body: Column(
        children: [
          ListaCompraHeader(nombre: 'EasyShop - Lista de Compra', color: color),
          construirPantallaPaginaPrincipal(color),
        ],
      ),

      floatingActionButton: Container(
        width: 200,
        margin: EdgeInsets.only(bottom: 20),
        child: FloatingActionButton.extended(
          backgroundColor: color,
          onPressed: () {
            final manager = Provider.of<ListaListasCompra>(context, listen: false);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) {
                      return PaginaPrincipalAnadirLista(
                        crearLista: (listaCompra) {
                          manager.anadeLista(listaCompra);
                          Util.instance.guardarDatos(manager);
                          Navigator.pop(context);
                        },

                        editarLista: (listaCompra) {},
                        colorTema: color,
                      );
                    }
                )
            );
          },
          label: const Text('Añadir nueva lista'),
        ),
      ),
    );
  }

  Widget construirPantallaPaginaPrincipal(Color color) {
    return Consumer<ListaListasCompra>(
      builder: (context, manager, child) {
        if (manager.listas.isNotEmpty) {
          return PaginaPrincipalPantallaLlena(listasDeCompra: manager, color: color,);
        } else {
          return PaginaPrincipalPantallaVacia(color: color,);
        }
      },
    );
  }


}