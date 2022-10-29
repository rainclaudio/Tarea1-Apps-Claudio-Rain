import 'dart:convert';
import 'dart:io';
// import 'package:universal_io/io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tarea1/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:tarea1/providers/providers.dart';


class MensajeService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-ab2ab-default-rtdb.firebaseio.com';

  final List<Mensaje> messages = [];
  late Mensaje selectedMessage;

  final storage = const FlutterSecureStorage();

  File? newPictureFile;

  bool isLoading = true;
  bool isSaving = false;

  MensajeService() {
    loadMessages();
  }
  // Cargar Mensajes
  Future<List<Mensaje>> loadMessages() async {
    isLoading = true;
    notifyListeners();

    // GET messages
    final url = Uri.https(_baseUrl, 'mensajes.json', {
      // aquí va el argumento de el token
      'auth': await storage.read(key: 'token') ?? ''
    });
    final resp = await http.get(url, headers: {});
    final hola = json.decode(resp.body);
    if (resp.body == 'null')print("hola mundo estamos en null");
    print("podemos modificar mientras debuggeamos");
    final Map<String, dynamic> produtsMap = hola != null ? json.decode(resp.body): <String,int>{};
    // mapear y agregar al arreglo lcal
    produtsMap.forEach((key, value) {
      final tempMessage = Mensaje.fromMap(value);
      tempMessage.id = key;
      messages.add(tempMessage);
    });
    isLoading = false;
    notifyListeners();
    return messages;
  }

// este metodo me sirve para crear o actualizar un producto
  Future saveOrCreateProduct(Mensaje mensaje) async {
    isSaving = true;
    notifyListeners();
    if (mensaje.id == null) {
      // es necesario crear
      await createMessage(mensaje);
    } else {
      print("EXCEPTION");
    }
    isSaving = false;
    notifyListeners();
  }

  // !importante: tenemos que acutalizar para poder crear el login feature , de momento puede ser un placeholder
  Future<String> createMessage(Mensaje mensaje) async {
    print('creando mensaje');
    final url = Uri.https(_baseUrl, 'mensajes.json',
        {'auth': await storage.read(key: 'token') ?? ''});

    // post es para crear
    final resp = await http.post(url, body: mensaje.toJson());
    final decodedData = json.decode(resp.body);

    mensaje.id = decodedData['name'];
    messages.add(mensaje);

    return mensaje.id!;
  }


}