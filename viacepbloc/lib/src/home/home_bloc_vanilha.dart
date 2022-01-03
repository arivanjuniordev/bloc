import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uno/uno.dart';

class HomeBlocVanilha {
  final textEditingController = TextEditingController(text: '59646337');

  final _streamController = StreamController<String>.broadcast();

  Sink get searchCep => _streamController.sink;

  Stream<Map<String, dynamic>> get cepResult =>
      _streamController.stream.asyncMap(_searchCep);

  Future<Map<String, dynamic>> _searchCep(String cep) async {
    try {
      final response = await Uno().get('https://viacep.com.br/ws/$cep/json/');

      return response.data;
    } catch (e) {
      throw Exception('Erro ao Pesquisar');
    }
  }

  void dispose() {
    _streamController.close();
  }
}
