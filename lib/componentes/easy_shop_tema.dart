import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EasyShopTema {

  static ThemeData claro() {
    return ThemeData( //representan tema en una aplciacion. En el se encapsulan aspectos visuales de vistas (colores, tipo letra, ...)
      brightness: Brightness.light, //para cuando la app este en modo CLARO

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateColor.resolveWith((states) {
          return Colors.black;
        },
        ),
      ),

      appBarTheme: const AppBarTheme( //para especificar colores de la barra de aplicacion
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),

      floatingActionButtonTheme: const

      FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xff67EC64),
      ),

      bottomNavigationBarTheme: const

      BottomNavigationBarThemeData(
        selectedItemColor: Colors.green,
      ),

      textTheme: temaTextoClaro, //tema de texto asociado al tema
    );
  }

  static TextTheme temaTextoClaro = TextTheme(
    bodyLarge: GoogleFonts.openSans(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),

    bodyMedium: GoogleFonts.openSans(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),

    displayLarge: GoogleFonts.openSans(
      fontSize: 25.0,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),

    displayMedium: GoogleFonts.openSans(
      fontSize: 25.0,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),

    displaySmall: GoogleFonts.openSans(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),

    titleLarge: GoogleFonts.openSans(
      fontSize: 40.0,
      fontWeight: FontWeight.w600,
      color: Color(0xff67EC64),
    ),

    titleSmall: GoogleFonts.openSans(
      fontSize: 20.0,
      fontWeight: FontWeight.w300,
      color: Color(0xff67EC64),
    ),

    titleMedium: GoogleFonts.openSans(
      fontSize: 20.0,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),

  );

  //---------------------------------------------------------------------------------

  static ThemeData oscuro() {
    return ThemeData( //representan tema en una aplciacion. En el se encapsulan aspectos visuales de vistas (colores, tipo letra, ...)
      brightness: Brightness.dark, //para cuando la app este en modo OSCURO

      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateColor.resolveWith((states) {
          return Colors.white;
        },
        ),
      ),

      appBarTheme: const AppBarTheme( //para especificar colores de la barra de aplicacion
        foregroundColor: Colors.white,
        backgroundColor: Colors.indigo,
      ),

      floatingActionButtonTheme: const

      FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
      ),

      bottomNavigationBarTheme: const

      BottomNavigationBarThemeData(
        selectedItemColor: Colors.green,
      ),

      textTheme: temaTextoOscuro, //tema de texto asociado al tema
    );
  }

  static TextTheme temaTextoOscuro = TextTheme(
    bodyLarge: GoogleFonts.openSans(
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
      color: Colors.white,
    ),

    bodyMedium: GoogleFonts.openSans(
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
      color: Colors.white,
    ),

    displayLarge: GoogleFonts.openSans(
      fontSize: 25.0,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),

    displayMedium: GoogleFonts.openSans(
      fontSize: 25.0,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),

    displaySmall: GoogleFonts.openSans(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),

    titleLarge: GoogleFonts.openSans(
      fontSize: 40.0,
      fontWeight: FontWeight.w600,
      color: Color(0xff67EC64),
    ),

    titleSmall: GoogleFonts.openSans(
      fontSize: 20.0,
      fontWeight: FontWeight.w300,
      color: Color(0xff67EC64),
    ),

    titleMedium: GoogleFonts.openSans(
      fontSize: 20.0,
      fontWeight: FontWeight.w400,
      color: Colors.white,
    ),
  );
}