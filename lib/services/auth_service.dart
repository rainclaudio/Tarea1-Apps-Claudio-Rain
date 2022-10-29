import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyBeEsEhRzTzi1OFtgKdLC1vQEY76B-MmCU';

  final storage = const FlutterSecureStorage();
  
  late  String email = '';
  late  String password = '';

// si retornamos algo, será un error, si no todo, bien
  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});

    // final resp = await http.post(url, body: json.encode(authData));
    // final Map<String, dynamic> decodedResp = json.decode(resp.body);

    final resp = await http.post(url, body: json.encode(authData));

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      storage.write(key: 'token', value: decodedResp['idToken']);
      // tenemos que grabar el token en un lugar seguro
      // return decodedResp['idToken'];
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future<String?> login(String email, String password) async {
    this.email = email;
    this.password = password;
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.https(
        _baseUrl, '/v1/accounts:signInWithPassword', {'key': _firebaseToken});

    // final resp = await http.post(url, body: json.encode(authData));
    // final Map<String, dynamic> decodedResp = json.decode(resp.body);

    final resp = await http.post(url, body: json.encode(authData));

    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      // tenemos que grabar el token en un lugar seguro
      // return decodedResp['idToken'];
      storage.write(key: 'token', value: decodedResp['idToken']);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future logout() async {
    email = '';
    password = '';
    await storage.delete(key: 'token');
    return null;
  }

// verificamos si tenemos token
  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
