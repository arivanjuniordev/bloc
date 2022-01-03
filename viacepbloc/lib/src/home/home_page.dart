import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viacepbloc/src/home/flutter_bloc/home_flutter_bloc.dart';
import 'package:viacepbloc/src/home/flutter_bloc/search_cep_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeBloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Column(
          children: [
            TextField(
              controller: homeBloc.textEditingController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Cep:',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () =>
                  homeBloc.add(homeBloc.textEditingController.text),
              child: const Text('Pesquisar'),
            ),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<HomeBloc, SearchCepState>(
              bloc: homeBloc,
              builder: (context, state) {
                if (state is SearchCepError) {
                  return Text(state.message);
                }

                if (state is SearchCepLoading) {
                  return const CircularProgressIndicator();
                }

                state = state as SearchCepSucess;

                return Text("Cidade: ${state.data['localidade']}");
              },
            ),
          ],
        ),
      ),
    );
  }
}
