import 'package:flutter/material.dart';
import 'package:proyecto_moviles/modelos/lista_listas_compra.dart';
import 'package:proyecto_moviles/pantallas/ListaCompraPantalla/lista_compra_pantalla_vacia.dart';
import 'package:proyecto_moviles/pantallas/ListaCompraPantalla/lista_compra_pantalla_llena.dart';
import 'package:provider/provider.dart';
import 'package:proyecto_moviles/modelos/lista_compra.dart';
import '../../componentes/lista_compra_header.dart';
import '../../patron_orden/undo_manager.dart';
import '../../patron_orden/producto/orden_borrar_marcados.dart';
import '../../util/util.dart';
import 'lista_compra_anadir_producto.dart';

class ListaCompraPantalla extends StatelessWidget {
  const ListaCompraPantalla({super.key, required this.listaCompra, required this.listasDeCompra});

  final ListaCompra listaCompra;
  final ListaListasCompra listasDeCompra;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListaCompra>.value(
      value: listaCompra,
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        key: GlobalKey<ScaffoldState>(),

        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            crearMenuDesplegable(context),
          ],
        ),

        extendBodyBehindAppBar: true,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListaCompraHeader(nombre: listaCompra.nombre, color : listaCompra.color),

            Consumer<ListaCompra>(
              builder: (context, listaCompra, child) {
                return listaCompra.productos.isNotEmpty
                    ? ListaCompraPantallaLlena(listaCompra: listaCompra, listasDeCompra: listasDeCompra, color: listaCompra.color)
                    : ListaCompraPantallaVacia(listaCompra: listaCompra);
              },
            ),
          ],
        ),

        floatingActionButton: Container(
          width: 200,
          margin: EdgeInsets.only(bottom: 20),
          child: FloatingActionButton.extended(
            backgroundColor: listaCompra.color,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ListaCompraAnadirProducto(
                      crearProducto: (producto) {
                        listaCompra.anadeProducto(producto);
                        Util.instance.guardarDatos(listasDeCompra);
                        Navigator.pop(context);
                      },
                      editarProducto: (producto) {},
                      listaDeListas: listasDeCompra,
                      colorTema: listaCompra.color,
                    );
                  },
                ),
              );
            },
            label: const Text('Añadir producto'),
          ),
        ),
      ),
    );
  }

  void mostrarSnackBar(BuildContext context, bool b) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(b ? 'Productos marcados eliminados' : 'No hay productos marcados'),
        action: b
            ? SnackBarAction(
          label: 'Deshacer',
          onPressed: () {
            UndoManager.instance.undo();
            Util.instance.guardarDatos(listasDeCompra);
          },
        )
            : null,
      ),
    );
  }

  Widget crearMenuDesplegable (BuildContext context){
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'borrarMarcados') {
          if (listaCompra.comprobarHayCompletados()){
            OrdenBorrarMarcados(listaCompra).execute();
            Util.instance.guardarDatos(listasDeCompra);
            mostrarSnackBar(context, true);
          }else{
            mostrarSnackBar(context, false);
          }
        }
      },
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: 'borrarMarcados',
            child: Text(
                style: TextStyle(color: listaCompra.color),
                'Borrar marcados'),
          ),
        ];
      },
    );
  }
}

