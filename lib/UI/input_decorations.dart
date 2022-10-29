import 'package:flutter/material.dart';

class InputsDecorations {
  static InputDecoration authInputDecoration(
      {required String hintText,
      required String labelText,
      IconData? prefixIcon}) {
    return InputDecoration(
        enabledBorder: InputBorder.none,
        filled: true,
        fillColor: Color(0xFFf0ebf8),        
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple, width: 2),
        ),
        // Aquí va la ayuda: 'hola@123.com'
       
        hintText: hintText,
        // aquí va la etiqueta: 'Correo electrónico'
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.grey),
        alignLabelWithHint: true,
        // Aquí va el Icon
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: Colors.deepPurple,
              )
            : null);
  }
}
