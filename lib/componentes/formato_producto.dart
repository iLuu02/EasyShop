import 'package:flutter/material.dart';
import 'package:proyecto_moviles/modelos/Producto.dart';

class FormatoProducto extends StatelessWidget {
  final Producto producto;
  final Color color;
  final Function(bool?)? completar;
  final Function(bool?)? favorito;

  FormatoProducto({Key? key, required this.producto, this.completar, this.favorito}) :
        color = Colors.white,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    double precioTotal = producto.precio * producto.cantidad;

    return Container(

      height: 80.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
      Row(
      children: <Widget>[
        const SizedBox(width: 8,),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            producto.nombre,
            style: TextStyle(
              color: Colors.white,
              decoration: producto.completado ? TextDecoration.lineThrough : TextDecoration.none,
              decorationColor: Colors.black38,
              decorationThickness: 2.0,
              fontSize: 25.0,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            precioTotal.toString() + ' € - ' + producto.precio.toString() + ' €/u',
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ],
      ),
      ],
    ),
          Row(
            children: <Widget>[
              Text(
                producto.cantidad.toString() + "u" ,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              const SizedBox(width: 35,),

              Transform.scale(
                scale: 1.75,
                child: Checkbox(
                  value: producto.completado,
                  onChanged: completar,
                  fillColor: MaterialStateProperty.all(Colors.white),
                  checkColor: Colors.black,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.grey, width: 2.0),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

}