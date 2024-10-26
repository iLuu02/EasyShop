import 'dart:collection';

import 'package:proyecto_moviles/modelos/Producto.dart';
import 'package:proyecto_moviles/modelos/lista_compra.dart';
import 'package:proyecto_moviles/patron_orden/patron_orden.dart';
import 'package:proyecto_moviles/patron_orden/undo_manager.dart';

class OrdenBorrarMarcados implements Orden {
  ListaCompra lista;

  HashMap<Producto, int> antesBorrar = HashMap<Producto, int>(); //cuando se haga undo

  OrdenBorrarMarcados(this.lista);

  @override
  void execute() {
    HashMap<Producto, int> prodMarcados = lista.productosMarcados;
    antesBorrar = prodMarcados;

    List<String> ids = [];
    prodMarcados.forEach((key, value) {
      int posicion = lista.productos.indexOf(key);
      String id = lista.productos.elementAt(posicion).id;
      ids.add(id);
    });

    for (var i in ids) {
      lista.borrarProductosPorId(i);
    }
    
    UndoManager.instance.add(orden: this);
  }

  @override
  void undo() {
    antesBorrar.forEach((key, value) {
      lista.anadeProductoEnPosicion(key,value);
    });
  }

  @override
  void redo() {
    HashMap<Producto, int> prodMarcados = lista.productosMarcados;

    prodMarcados.forEach((key, value) {
      int indice = lista.productos.indexOf(key);
      lista.borraProducto(indice);
    });
  }
}
