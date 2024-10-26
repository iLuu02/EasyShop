import 'package:flutter/material.dart';
import 'package:proyecto_moviles/modelos/lista_listas_compra.dart';
import 'package:proyecto_moviles/modelos/lista_compra.dart';
import 'package:proyecto_moviles/pantallas/PaginaPrincipalPantalla/pagina_principal_anadir_lista.dart';
import '../../patron_orden/Listas_de_listas/orden_borrar_lista_compra.dart';
import '../../patron_orden/undo_manager.dart';
import '../../util/util.dart';
import '../ListaCompraPantalla/lista_compra_pantalla.dart';

class PaginaPrincipalPantallaLlena extends StatelessWidget {
  const PaginaPrincipalPantallaLlena(
      {super.key, required this.listasDeCompra, required this.color});
  final ListaListasCompra listasDeCompra;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final listas = listasDeCompra.listas;

    return Expanded(
      child: ListView.builder(
        itemCount: listas.length,
        itemBuilder: (BuildContext context, index) {
          final listaIndividual = listas[index];

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Dismissible(
              key: Key(listaIndividual.id),
              direction: DismissDirection
                  .endToStart, // Aquí establecemos que solo se permita de derecha a izquierda
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: const Icon(Icons.delete_forever,
                    color: Colors.white, size: 35.0),
              ),

              confirmDismiss: (DismissDirection direction) async {
                if (direction == DismissDirection.endToStart) {
                  OrdenBorrarListaCompra(listasDeCompra, index).execute();
                  Util.instance.guardarDatos(listasDeCompra);
                  mostrarSnackBarEliminarLista(
                      context, listaIndividual, listasDeCompra);
                  return true; // Devuelve 'true' para confirmar el dismiss
                }
                return false; // Devuelve 'false' si no se quiere proceder
              },

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  foregroundColor: Colors.white,
                ),
                key: Key(listaIndividual.id),
                onPressed: () {
                  Navigator.of(context)
                      .push(_createRoute(listaIndividual, listasDeCompra));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 60.0,
                      child: Center(
                        child: Text(
                          listaIndividual.nombre,
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ),
                    ),
                    construirMenuDesplegable(context, listaIndividual, index),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget construirMenuDesplegable(
      BuildContext context, ListaCompra listaIndividual, int index) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        switch (value) {
          case '1':
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PaginaPrincipalAnadirLista(
                  listaOriginal: listaIndividual,
                  crearLista: (listaCompra) {},
                  editarLista: (listaCompra) {
                    listasDeCompra.actualizaLista(listaCompra, index);
                    Util.instance.guardarDatos(listasDeCompra);
                    Navigator.pop(context);
                  },
                  colorTema: color,
                ),
              ),
            );
            break;
          case '2':
            OrdenBorrarListaCompra(listasDeCompra, index).execute();
            Util.instance.guardarDatos(listasDeCompra);
            mostrarSnackBarEliminarLista(
                context, listaIndividual, listasDeCompra);
            break;
        }
      },
      itemBuilder: (BuildContext context) {
        // Crear elementos del menú
        return <PopupMenuEntry<String>>[
          PopupMenuItem<String>(
            value: '1',
            child: Text(
              'Editar lista',
              style: TextStyle(color: color),
            ),
          ),
          PopupMenuItem<String>(
            value: '2',
            child: Text(
              'Eliminar lista',
              style: TextStyle(color: color),
            ),
          ),
        ];
      },
      child: Icon(Icons.menu),
    );
  }
}

Route _createRoute(ListaCompra listaCompra, ListaListasCompra listasDeCompra) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        ListaCompraPantalla(
            listaCompra: listaCompra, listasDeCompra: listasDeCompra),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

void mostrarSnackBarEliminarLista(BuildContext context,
    ListaCompra listaIndividual, ListaListasCompra lista) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('${listaIndividual.nombre} eliminado'),
      action: SnackBarAction(
        label: 'Deshacer',
        onPressed: () {
          UndoManager.instance.undo();
          Util.instance.guardarDatos(lista);
        },
      ),
    ),
  );
}
