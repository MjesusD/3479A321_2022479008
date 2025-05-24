import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppData extends ChangeNotifier {
  int _counter = 0;
  String _userName = "Usuario_1";
  bool _canReset = true;

  int get counter => _counter;
  String get userName => _userName;
  bool get canReset => _canReset;

  // Incrementa y guarda en preferencias
  void increment() {
    _counter++;
    notifyListeners();
    _saveCounter();
  }

  // Decrementa y guarda en preferencias
  void decrement() {
    _counter--;
    notifyListeners();
    _saveCounter();
  }

  // Resetea solo si _canReset es true
  void reset() {
    if (_canReset) {
      _counter = 0;
      notifyListeners();
      _saveCounter();
    }
  }

  void setUserName(String name) {
    _userName = name;
    notifyListeners();
   
  }

  void setCanReset(bool value) {
    _canReset = value;
    notifyListeners();
    _saveCanReset();
  }

  //Carga los valores desde SharedPreferences
  Future<void> loadPreferencias() async {
    final prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('counter') ?? 0;
    _canReset = prefs.getBool('canReset') ?? true;
    notifyListeners();
  }

  //Guarda el contador
  Future<void> _saveCounter() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', _counter);
  }

  //Guarda el estado de canReset
  Future<void> _saveCanReset() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('canReset', _canReset);
  }
}
