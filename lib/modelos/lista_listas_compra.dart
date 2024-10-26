import 'dart:convert';

import 'package:flutter/material.dart';
import 'lista_compra.dart';


class ListaListasCompra extends ChangeNotifier{ //es change notifier porque ListaCompra es un observable que contiene estado mutable cuyos cambios se quieren observar desde otras vistas
  final List<ListaCompra> _listas;

  ListaListasCompra() : _listas = [];

  ListaListasCompra.copia(ListaListasCompra listasCompra)
      : _listas = List.from(listasCompra._listas);

  void borraLista(int indice){
    _listas.removeAt(indice);
    notifyListeners(); //informa a los observadores que hay cambios
  }

  void anadeLista(ListaCompra item){
    _listas.add(item);
    notifyListeners(); //informa a los observadores que hay cambios
  }

  void anadeListaEnPosicion(ListaCompra item, int index){
    _listas.insert(index, item);
    notifyListeners(); //informa a los observadores que hay cambios
  }

  void actualizaLista(ListaCompra item, int indice) {
    _listas[indice] = item;
    notifyListeners(); //informa a los observadores que hay cambios
  }

  List<ListaCompra> get listas => List.unmodifiable(_listas);

  set productos(List<ListaCompra> value) {
    _listas.clear();
    _listas.addAll(value);
    notifyListeners();
  }

  String toJsonString() {
    List<Map<String, dynamic>> listas =
    _listas.map((lista) => lista.toJson()).toList();

    return jsonEncode({"listas": listas});
  }

  static ListaListasCompra fromJsonString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);

    List<ListaCompra> listas = json["listas"]
        .map<ListaCompra>((listaJson) => ListaCompra.fromJson(listaJson))
        .toList();

    return ListaListasCompra().._listas.addAll(listas);
  }
}