import 'package:flutter/material.dart';

import '../../modelos/lista_compra.dart';

class ListaCompraPantallaVacia extends StatelessWidget{ //Esta vista se mostrará cuando no haya productos en la lista. Esta vista no cambia, por eso es subclase de Stateless
  const ListaCompraPantallaVacia({super.key, required this.listaCompra});
  final ListaCompra listaCompra;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 64.0,),
            Image.asset(
              'assets/images/verdura.png',
              width: 200,
            ),
              const SizedBox(height: 16.0,),
            Text(
              'Tu lista está vacía',
              style: TextStyle(
                color: listaCompra.color // Color del texto
              ),
            ),
              const SizedBox(height: 6.0,),
            Text(
              'Añade productos pulsando sobre\n el botón añadir producto',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

}