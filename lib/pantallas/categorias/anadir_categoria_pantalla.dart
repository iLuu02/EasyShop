import 'package:flutter/material.dart';

import '../../componentes/lista_compra_header.dart';
import '../../modelos/lista_categorias_singleton.dart';

class AnadirCategoriaPantalla extends StatefulWidget {
  final Color color;
  const AnadirCategoriaPantalla({super.key, required this.color});
  @override
  AnadirCategoriaPantallaState createState() => AnadirCategoriaPantallaState();
}

class AnadirCategoriaPantallaState extends State<AnadirCategoriaPantalla> {
  final TextEditingController _nombreCategoriaController = TextEditingController();

  @override
  void dispose() {
    _nombreCategoriaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              icon: const Icon(Icons.check),
              onPressed: () {
                final nuevaCategoria = _nombreCategoriaController.text;
                if (nuevaCategoria.isNotEmpty) {
                  CategoriaSingleton.instance.addCategoria(nuevaCategoria);
                  Navigator.of(context).pop(); //
                }
              }
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      extendBodyBehindAppBar: true,

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListaCompraHeader(nombre: 'Añadir una categoría', color: widget.color),
          Padding(
            padding: const EdgeInsets.only(top:32.0, left:16, right:16),
            child: TextField(
              controller: _nombreCategoriaController,
              style: TextStyle(color: widget.color),
              decoration: InputDecoration(
                labelText: 'Nombre',
                hintText: 'Introduce el nombre de la categoria',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
