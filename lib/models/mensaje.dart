// To parse this JSON data, do
//
//     final products = productsFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class Mensaje {
    Mensaje({
        required this.login,
        required this.texto,
        required this.titulo,
        this.id
    });

    String login;
    String texto;
    String titulo;

    String? id;


    factory Mensaje.fromJson(String str) => Mensaje.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Mensaje.fromMap(Map<String, dynamic> json) => Mensaje(
        login: json["login"],
        texto: json["texto"],
        titulo: json["titulo"],
    );

    Map<String, dynamic> toMap() => {
        "login": login,
        "texto": texto,
        "titulo": titulo,
    };
}
