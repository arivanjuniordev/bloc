import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uno/uno.dart';
import 'package:rxdart/rxdart.dart';
import 'package:viacepbloc/src/home/flutter_bloc/search_cep_state.dart';

class HomeBlocVanilhaState {
  final textEditingController = TextEditingController(text: '59646337');

  final _streamController = StreamController<String>.broadcast();

  Sink<String> get searchCep => _streamController.sink;

  Stream<SearchCepState> get cepResult =>
      _streamController.stream.switchMap(_searchCep);

  Stream<SearchCepState> _searchCep(String cep) async* {
    yield SearchCepLoading();

    try {
      final response = await Uno().get('https://viacep.com.br/ws/$cep/json/');

      yield SearchCepSucess(response.data);
    } catch (e) {
      yield SearchCepError('Erro ao Pesquisar');
    }
  }

  void dispose() {
    _streamController.close();
  }

  //ui
  // StreamBuilder<SearchCepState>(
  //             stream: homeBloc.cepResult,
  //             builder: (context, snapshot) {
  //               if (!snapshot.hasData) {
  //                 return Container();
  //               }

  //               var state = snapshot.data;

  //               if (state is SearchCepError) {
  //                 return Text("${snapshot.error}");
  //               }

  //               if (state is SearchCepLoading) {
  //                 return const CircularProgressIndicator();
  //               }

  //               state = state as SearchCepSucess;

  //               return Text("Cidade: ${state.data['localidade']}");
  //             },
  //           ),
}
