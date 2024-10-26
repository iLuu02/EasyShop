import 'package:flutter/material.dart';
import 'package:proyecto_moviles/componentes/categoria_header.dart';
import 'package:collection/collection.dart';

import 'package:proyecto_moviles/modelos/lista_compra.dart';

import '../../componentes/formato_producto.dart';
import '../../modelos/Producto.dart';
import '../../modelos/lista_listas_compra.dart';
import '../../patron_orden/undo_manager.dart';
import '../../patron_orden/producto/orden_borrar_producto.dart';
import '../../util/util.dart';
import 'lista_compra_anadir_producto.dart';

class ListaCompraPantallaLlena extends StatelessWidget {
  const ListaCompraPantallaLlena({super.key, required this.listaCompra, required this.listasDeCompra, required this.color});
  final ListaCompra listaCompra;
  final ListaListasCompra listasDeCompra;
  final Color color;

  @override
  Widget build(BuildContext context) {
    // Agrupar los productos por categoría
    final productos =listaCompra.productos;
    final productosPorCategoria =
    groupBy(productos, (producto) => producto.categoria);

    // Crear una lista de categorías y productos
    final categorias = productosPorCategoria.entries.toList();

    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: categorias.length,
        itemBuilder: (BuildContext context, int indexCategorias) {
          final categoria = categorias[indexCategorias];
          final productosDeCategoria = categoria.value;

          return Column(
            children: [
              CategoriaHeader(categoria: categoria.key, color: Util.instance.darken(listaCompra.color, 0.25)),
              ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: productosDeCategoria.length,
                itemBuilder: (BuildContext context, int indexProducto) {
                  final producto = productosDeCategoria[indexProducto];
                  int indexOriginal = productos.indexOf(producto);

                  return Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
                    child: Dismissible(
                      key: Key(producto.id),
                      direction: DismissDirection.horizontal,

                      background: Container(
                        decoration:BoxDecoration(
                          color: Colors.green, // establece el color de fondo en verde oscuro
                          borderRadius: BorderRadius.circular(30), // establece las esquinas redondeadas con un radio de 10 unidades
                        ),
                        alignment: Alignment.centerLeft,
                        child: const Icon(Icons.star, color: Colors.white, size: 35.0),
                      ),

                      secondaryBackground: Container(
                        decoration:BoxDecoration(
                          color: Colors.red, // establece el color de fondo en verde oscuro
                          borderRadius: BorderRadius.circular(30), // establece las esquinas redondeadas con un radio de 10 unidades
                        ),
                        alignment: Alignment.centerRight,
                        child: const Icon(Icons.delete_forever, color: Colors.white, size: 35.0),
                      ),

                      confirmDismiss: (DismissDirection direction) async {
                        if (direction == DismissDirection.startToEnd) {
                          listaCompra.marcaFavorito(indexOriginal, listaCompra.productos.elementAt(indexOriginal).favorito ? false : true);
                          listaCompra.ordenarListaProductosMarcados();
                          Util.instance.guardarDatos(listasDeCompra);
                        }

                        listaCompra.ordenarListaProductosMarcados();
                        Util.instance.guardarDatos(listasDeCompra);

                        return direction == DismissDirection.startToEnd ? false : true;

                      },

                      onDismissed: (DismissDirection direction) {
                        if (direction == DismissDirection.endToStart) {
                          OrdenBorrarProducto(listaCompra, indexOriginal).execute();
                          Util.instance.guardarDatos(listasDeCompra);

                          mostrarSnackBar(context, producto.nombre);

                        }

                        listaCompra.ordenarListaProductosMarcados();
                        Util.instance.guardarDatos(listasDeCompra);
                      },

                      child: construirProducto(producto, context, indexOriginal),
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  void mostrarSnackBar(BuildContext context, String nombre){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$nombre eliminado'),
        action: SnackBarAction(
          label: 'Deshacer',
          onPressed: () {
            UndoManager.instance.undo();
            Util.instance.guardarDatos(listasDeCompra);
          },
        ),
      ),
    );
  }

  Widget construirProducto(Producto producto, BuildContext context, int indexOriginal){
    return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: listaCompra.color,   // Reemplaza `primary` con `backgroundColor`
      foregroundColor: Colors.white,        // Reemplaza `onPrimary` con `foregroundColor`
    ),

      key: Key(producto.id),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ListaCompraAnadirProducto(
              productoOriginal: producto,
              editarProducto: (producto) {
                listaCompra.actualizaProducto(producto, indexOriginal);
                Util.instance.guardarDatos(listasDeCompra);
                Navigator.pop(context);
              },
              crearProducto: (producto) {},
              colorTema: listaCompra.color,
              listaDeListas: listasDeCompra,
            ),
          ),
        );
      },
      child: FormatoProducto(
        producto: producto,
        completar: (valor) {
          if (valor != null) {
            listaCompra.marcaCompletado(listaCompra.productos.indexOf(producto), valor);
            listaCompra.ordenarListaProductosMarcados();
            Util.instance.guardarDatos(listasDeCompra);
          }
        },
      ),
    );
  }
}
