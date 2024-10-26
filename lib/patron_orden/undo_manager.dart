import 'package:flutter/material.dart';
import 'package:proyecto_moviles/patron_orden/estructura_pila.dart';
import 'package:proyecto_moviles/patron_orden/patron_orden.dart';

class UndoManager extends ChangeNotifier{
  final _undoPila = Pila<Orden>();
  final _redoPila = Pila<Orden>();

  UndoManager();

  UndoManager._();

  static final UndoManager instance = UndoManager._();

  void add({required Orden orden}) {
    _undoPila.push(orden);
    _redoPila.clear();
  }

  void undo() {
    if (!_undoPila.isEmpty()) {
      final command2Undo = _undoPila.pop();
      command2Undo.undo();
      _redoPila.push(command2Undo);
    }
  }

  void redo() {
    if (!_redoPila.isEmpty()) {
      final command2Redo = _redoPila.pop();
      command2Redo.redo();
      _undoPila.push(command2Redo);
    }
  }

  @override
  String toString() {
    return 'Commands to undo: $_undoPila\nCommands to redo: $_redoPila';
  }
}
