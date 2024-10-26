import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyecto_moviles/modelos/Producto.dart';
import 'package:uuid/uuid.dart';
import '../../componentes/lista_compra_header.dart';
import '../../modelos/lista_categorias_singleton.dart';
import '../../modelos/lista_listas_compra.dart';
import '../categorias/anadir_categoria_pantalla.dart';

class ListaCompraAnadirProducto extends StatefulWidget {
  final Function(Producto) crearProducto;
  final Function(Producto) editarProducto;
  final Producto? productoOriginal;
  final ListaListasCompra listaDeListas;
  final Color colorTema;
  final bool actualizando;



  const ListaCompraAnadirProducto({
    super.key,
    required this.crearProducto,
    required this.editarProducto,
    required this.listaDeListas,
    required this.colorTema,
    this.productoOriginal,
  }) : actualizando = (productoOriginal != null);

  @override
  ListaCompraAnadirProductoState createState() => ListaCompraAnadirProductoState();
}

class ListaCompraAnadirProductoState extends State<ListaCompraAnadirProducto> {
  final _controladorNombre = TextEditingController();
  final _controladorCantidad = TextEditingController(text: '0');
  final _controladorPrecio = TextEditingController(text: '0.0');
  String _categoriaSeleccionada = '';

  @override
  void initState() {
    super.initState();

    final productoOriginal = widget.productoOriginal;

    if (productoOriginal != null) {
      _controladorNombre.text = productoOriginal.nombre;
      _controladorCantidad.text = productoOriginal.cantidad.toString();
      _controladorPrecio.text = productoOriginal.precio.toString();
      _categoriaSeleccionada = productoOriginal.categoria;
    }

    _controladorNombre.addListener(() {
      setState(() { });
    });
  }

  @override
  void dispose() {
    _controladorNombre.dispose();
    _controladorPrecio.dispose();
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
              final producto = Producto(
                id: widget.productoOriginal?.id ?? const Uuid().v1(),
                nombre: _controladorNombre.text,
                cantidad: int.parse(_controladorCantidad.text),
                precio: double.parse(_controladorPrecio.text),
                categoria: _categoriaSeleccionada,
              );
              if (widget.actualizando) {
                widget.editarProducto(producto);
              } else {
                widget.crearProducto(producto);
              }
            },
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      extendBodyBehindAppBar: true,

      body: Column(
        children: [
           ListaCompraHeader(nombre: 'Añadir / Editar producto', color: widget.colorTema),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0, right:16, bottom: 16),
              child: ListView(
                children: <Widget>[
                  construyeCampoNombre(),
                    const SizedBox(height: 30,),
                  construyeCampoPrecio(),
                    const SizedBox(height: 30,),
                  construyeCampoCantidad(),
                    const SizedBox(height: 30,),
                  construyeCampoCategoria(),
                  const SizedBox (height: 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget construyeCampoNombre() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          controller: _controladorNombre,
          style: TextStyle(color: widget.colorTema),
          decoration: InputDecoration(
            labelText: 'Nombre',
            hintText: 'Introduce el nombre del producto',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          ),
      ],
    );
  }


  Widget construyeCampoCantidad() {
    return TextField(
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      controller: _controladorCantidad,
      style: TextStyle(color: widget.colorTema),
      decoration: InputDecoration(
        labelText: 'Cantidad',
        hintText: 'Introduce una cantidad',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget construyeCampoPrecio() {
    return TextField(
      controller: _controladorPrecio,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
      ],
      style: TextStyle(color: widget.colorTema),
      decoration: InputDecoration(
        labelText: 'Precio',
        hintText: 'Introduce el precio del producto',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }

  Widget construyeCampoCategoria() {
    final categorias = CategoriaSingleton.instance.categorias;
    if (!categorias.contains(_categoriaSeleccionada)) {
      _categoriaSeleccionada = categorias[0];
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        InputDecorator(
          decoration: InputDecoration(
            labelText: 'Categoría',
            contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _categoriaSeleccionada,
              icon: const Icon(Icons.arrow_drop_down),
              onChanged: (String? nuevaCategoria) {
                setState(() {
                  _categoriaSeleccionada = nuevaCategoria!;
                });
              },
              items: categorias.map<DropdownMenuItem<String>>((String categoria) {
                return DropdownMenuItem<String>(
                  value: categoria,
                  child: Text(categoria,
                    style: TextStyle(
                      color: widget.colorTema // Establecer el color del texto
                    ),),
                );
              }).toList(),
            ),
          ),
        ),

        Center(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return AnadirCategoriaPantalla(color: widget.colorTema);
                },
              ));
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all<Color>(widget.colorTema), // Color de fondo del botón
            ),
            child:  Text('Añadir nueva categoría'),
          ),
        ),
      ],
    );
  }
}