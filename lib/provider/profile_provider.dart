import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  String _nombre = 'juanito';
  String _apellido = 'bananas';
  String get nombre => _nombre;
  set nombre(String value){
    _nombre = value;
    notifyListeners();
  }
  String get apellido => _apellido;
  set apellido(String value){
    _apellido = value;
    notifyListeners();
  }
}