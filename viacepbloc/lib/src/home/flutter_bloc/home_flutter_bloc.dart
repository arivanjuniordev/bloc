import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uno/uno.dart';
import 'package:viacepbloc/src/home/flutter_bloc/search_cep_state.dart';

class HomeBloc extends Bloc<String, SearchCepState> {
  final textEditingController = TextEditingController(text: '59646337');

  HomeBloc() : super(SearchCepSucess({}));

  @override
  Stream<SearchCepState> mapEventToState(String event) async* {
    yield SearchCepLoading();

    try {
      final response = await Uno().get('https://viacep.com.br/ws/$event/json/');

      yield SearchCepSucess(response.data);
    } catch (e) {
      yield SearchCepError('Erro ao Pesquisar');
    }
  }
}
