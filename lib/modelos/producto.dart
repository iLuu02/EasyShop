import 'dart:convert';





class Producto {
  final String id;
  final String nombre;
  final int cantidad;
  final double precio;
  final bool completado;
  final bool favorito;
  final String categoria;

  Producto({
    required this.id,
    required this.nombre,
    required this.cantidad,
    this.categoria = 'Sin asignar',
    this.precio = 0,
    this.completado = false,
    this.favorito = false,
  });

  Producto copiaSiNulo({String? id,
    String? nombre,
    int? cantidad,
    double? precio,
    bool? completado,
    bool? favorito,
    String? categoria}) {
    return Producto(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      cantidad: cantidad ?? this.cantidad,
      precio: precio ?? this.precio,
      completado: completado ?? this.completado,
      favorito: favorito ?? this.favorito,
      categoria: categoria ?? this.categoria,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nombre": nombre,
      "cantidad": cantidad,
      "categoria": categoria,
      "precio": precio,
      "completado": completado,
      "favorito": favorito,
    };
  }

  static Producto fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json["id"],
      nombre: json["nombre"],
      cantidad: json["cantidad"],
      categoria: json["categoria"],
      precio: json["precio"],
      completado: json["completado"],
      favorito: json["favorito"],
    );
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  static Producto fromJsonString(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return fromJson(json);
  }

}
