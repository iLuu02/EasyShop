import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:proyecto_moviles/modelos/Producto.dart';


class ListaCompra extends ChangeNotifier{ //es change notifier porque ListaCompra es un observable que contiene estado mutable cuyos cambios se quieren observar desde otras vistas
  final String id;
  final Color _color;
  String _nombre = "";
  final List<Producto> _productos;

  ListaCompra(this.id, this._nombre, this._color) : _productos = [];

  ListaCompra.copia(ListaCompra listaCompra):
        id = listaCompra.id,
        _nombre = listaCompra._nombre,
        _color = listaCompra._color,
        _productos = List.from(listaCompra._productos);

  void borraProducto(int indice){
    _productos.removeAt(indice);
    notifyListeners(); //informa a los observadores que hay cambios
  }

  void borrarMarcados (){
    _productos.removeWhere((producto) => producto.completado);
    notifyListeners();
  }

  void borrarProductosPorId(String idProducto) {
    _productos.removeWhere((producto) => producto.id == idProducto);
    notifyListeners();
  }


  void anadeProducto(Producto item){
    _productos.add(item);
    notifyListeners(); //informa a los observadores que hay cambios
  }

  void anadeProductoEnPosicion(Producto item, int index){
    _productos.insert(index, item);
    notifyListeners(); //informa a los observadores que hay cambios
  }

  void actualizaProducto(Producto item, int indice) {
    _productos[indice] = item;
    notifyListeners(); //informa a los observadores que hay cambios
  }

  void marcaCompletado(int indice, bool completado) {
    final producto = _productos[indice];
    _productos[indice] = producto.copiaSiNulo(completado: completado);
    notifyListeners(); //informa a los observadores que hay cambios
  }

  bool comprobarHayCompletados(){
    return _productos.any((producto) => producto.completado);
  }

  void marcaFavorito(int indice, bool fav) {
    final producto = _productos[indice];
    final String nombreFav;

    if(fav == true) {
      nombreFav = '🤍 ${_productos[indice].nombre}';
    }else{
      nombreFav = _productos[indice].nombre.split(' ')[1];
    }
    _productos[indice] = producto.copiaSiNulo(nombre: nombreFav, favorito: fav);
    notifyListeners(); //informa a los observadores que hay cambios
  }

  void ordenarListaProductosMarcados(){ //la idea es que los productos NO marcados estén arriba y los marcados abajo
    List<Producto> nuevaLista = List<Producto>.from(productos); nuevaLista.clear();

    List<Producto> marcados = List<Producto>.from(productos); marcados.clear();
    List<Producto> noMarcados = List<Producto>.from(productos); noMarcados.clear();

    for(int i=0;i<productos.length;i++){
      Producto p = productos.elementAt(i);

      if(p.completado == false){
        noMarcados.add(p);
      }else{
        marcados.add(p);
      }
    }

    //ordenamos los productos segun su importancia

    for(int cont = 0; cont<2; cont++){
      List<Producto> lista;

      if(cont == 0){
        lista = noMarcados;
      }else{
        lista = marcados;
      }

      List<Producto> fav = List<Producto>.from(productos); fav.clear();

      for(int i=0;i<lista.length;i++){
        if(lista.elementAt(i).favorito == true){
          fav.add(lista.removeAt(i));
        }
      }


      for(int i=0;i<lista.length;i++){ //en vez de crear otra list de productos, reutilizamos esta list
        fav.add(lista.elementAt(i));
      }

      for(int i=0;i<fav.length;i++){ //en vez de crear otra list de productos, reutilizamos esta list
        nuevaLista.add(fav.elementAt(i));
      }

    }

    productos = nuevaLista;

  }

  int contarCompletados() {
    int completados = 0;
    for (Producto producto in _productos) {
      if (producto.completado) {
        completados++;
      }
    }
    return completados;
  }

  String get nombre => _nombre;
  Color get color => _color;
  List<Producto> get productos => _productos;
  int get numProductos => _productos.length;

  set nombre(String value) {
    _nombre = value;
    notifyListeners();
  }

  set productos(List<Producto> value) {
    _productos.clear();
    _productos.addAll(value);
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> productosJson =
    _productos.map((producto) => producto.toJson()).toList();

    String colorString = '#${_color.value.toRadixString(16).substring(2)}'; // Convertir el objeto Color en una cadena de texto hexadecimal sin opacidad

    return {
      "id": id,
      "nombre": _nombre,
      "color": colorString,
      "productos": productosJson,
    };
  }

  static ListaCompra fromJson(Map<String, dynamic> json) {
    List<Producto> productos = json["productos"]
        .map<Producto>((productoJson) => Producto.fromJson(productoJson))
        .toList();

    String colorString = json['color'];
    Color color = Color(int.parse(colorString.substring(1), radix: 16) + 0xFF000000); // Convertir la cadena de texto en un objeto Color

    return ListaCompra(json["id"], json["nombre"], color).._productos.addAll(productos);
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  static ListaCompra fromJsonString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return fromJson(json);
  }

  HashMap<Producto, int> get productosMarcados{
    HashMap<Producto, int> prodMarcados = HashMap<Producto, int>();

    for(int i=0;i<_productos.length;i++){
      if(_productos.elementAt(i).completado == true){
        prodMarcados.putIfAbsent(_productos.elementAt(i), () => i);
      }
    }

    return prodMarcados;
  }

}
