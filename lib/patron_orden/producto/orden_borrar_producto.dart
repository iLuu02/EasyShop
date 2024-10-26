import 'package:proyecto_moviles/modelos/Producto.dart';
import 'package:proyecto_moviles/modelos/lista_compra.dart';
import 'package:proyecto_moviles/patron_orden/patron_orden.dart';
import 'package:proyecto_moviles/patron_orden/undo_manager.dart';

class OrdenBorrarProducto implements Orden {
  ListaCompra lista;
  int indice;

  var antesBorrar = <Producto>[]; //cuando se haga undo
  var despuesBorrar = <Producto>[]; //cuando se haga redo

  OrdenBorrarProducto(this.lista, this.indice);

  @override
  void execute() {
    antesBorrar.insert(antesBorrar.length, lista.productos.elementAt(indice));
    lista.borraProducto(indice);
    UndoManager.instance.add(orden: this);
  }

  @override
  void undo() {
    lista.anadeProductoEnPosicion(antesBorrar[antesBorrar.length-1],indice);
  }

  @override
  void redo() {
    lista.borraProducto(indice);
  }
}
