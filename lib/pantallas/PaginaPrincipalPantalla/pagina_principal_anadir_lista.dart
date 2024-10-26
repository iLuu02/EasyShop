import 'package:flutter/material.dart';
import 'package:proyecto_moviles/modelos/lista_compra.dart';
import 'package:uuid/uuid.dart';
import '../../componentes/lista_compra_header.dart';
import '../../util/util.dart';

class PaginaPrincipalAnadirLista extends StatefulWidget {
  final Function(ListaCompra) crearLista;
  final Function(ListaCompra) editarLista;
  final ListaCompra? listaOriginal;
  final Color colorTema;
  final bool actualizando;

  const PaginaPrincipalAnadirLista({
    super.key,
    required this.crearLista,
    required this.editarLista,
    required this.colorTema,
    this.listaOriginal,
  }) : actualizando = (listaOriginal != null);

  @override
  PaginaPrincipalAnadirListaState createState() => PaginaPrincipalAnadirListaState();
}

class PaginaPrincipalAnadirListaState extends State<PaginaPrincipalAnadirLista> {
  final _controladorNombre = TextEditingController();

  @override
  void initState() {
    super.initState();

    final listaOriginal = widget.listaOriginal;

    if (listaOriginal != null) {
      _controladorNombre.text = listaOriginal.nombre;
    }

    _controladorNombre.addListener(() {
      setState(() { });
    });
  }

  @override
  void dispose() {
    _controladorNombre.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              final listaCompra = ListaCompra(
                  widget.listaOriginal?.id ?? const Uuid().v1(),
                  _controladorNombre.text,
                  Util.instance.getRandomColor()
              );
              if (widget.actualizando) {
                widget.editarLista(listaCompra);
              } else {
                widget.crearLista(listaCompra);
              }
            },
          ),
        ],
      ),

      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          ListaCompraHeader(nombre: 'Añadir / Editar lista', color: widget.colorTema),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: construyeCampoNombre(),
          ),
        ],
      ),
    );
  }

  Widget construyeCampoNombre() {
    return TextField(
      controller: _controladorNombre,
      style: TextStyle(color: widget.colorTema),
      decoration: InputDecoration(
        labelText: 'Nombre de la lista',
        hintText: 'Introduce el nombre de la lista',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}