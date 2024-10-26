import 'package:proyecto_moviles/modelos/lista_compra.dart';
import 'package:proyecto_moviles/modelos/lista_listas_compra.dart';
import 'package:proyecto_moviles/patron_orden/undo_manager.dart';
import 'package:proyecto_moviles/patron_orden/patron_orden.dart';

class OrdenBorrarListaCompra implements Orden {
  ListaListasCompra lista;
  int indice;

  var antesBorrar = <ListaCompra>[]; //cuando se haga undo
  var despuesBorrar = <ListaCompra>[]; //cuando se haga redo

  OrdenBorrarListaCompra(this.lista, this.indice);

  @override
  void execute() {
    antesBorrar.insert(antesBorrar.length, lista.listas.elementAt(indice));
    lista.borraLista(indice);
    UndoManager.instance.add(orden: this);
  }

  @override
  void undo() {
    lista.anadeListaEnPosicion(antesBorrar[antesBorrar.length-1],indice);
  }

  @override
  void redo() {
    lista.borraLista(indice);
  }
}
