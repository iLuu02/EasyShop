import 'package:flutter/material.dart';

class PaginaPrincipalPantallaVacia extends StatelessWidget{ //Esta vista se mostrará cuando no haya listas creadas.// Esta vista no cambia, por eso es subclase de Stateless
  const PaginaPrincipalPantallaVacia({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 35),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 64.0),
            Image.asset(
              'assets/images/fruta.png',
              width: 200,
            ),
            const SizedBox(height: 16.0,),
            Text(
              'Aún no has creado una lista',
              style: TextStyle(
                  color: color // Color del texto
              ),
            ),
            const SizedBox(height: 6.0,),
            Text(
              'Crea tu primera lista\n pulsando el botón añadir nueva lista',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}