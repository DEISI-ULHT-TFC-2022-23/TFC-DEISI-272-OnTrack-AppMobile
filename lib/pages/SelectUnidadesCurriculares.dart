import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tfc_ontack/UnidadeCurricular.dart';
import 'package:tfc_ontack/User.dart';
import 'package:tfc_ontack/services/api_requests.dart';

import '../static/Colors/Colors.dart';

List<int> unidadesSelecionadas = [];

class SelectUnidadesCurriculares extends StatefulWidget {
  final User user;

  SelectUnidadesCurriculares(this.user, {super.key});

  @override
  _SelectUnidadesCurricularesState createState() =>
      _SelectUnidadesCurricularesState();
}

class _SelectUnidadesCurricularesState
    extends State<SelectUnidadesCurriculares> {
  List<int> anos = [1, 2, 3];

  String tituloTile(int ano) {
    if (ano == 1) {
      return "1ºAno";
    } else if (ano == 2) {
      return "2ºAno";
    } else {
      return "3ºAno";
    }
  }

  @override
  void initState() {
    super.initState();
    fetchUnidadesFromAPI(widget.user.id).then((value) {
      setState(() {
        for (int i = 0; i < value.length; i++) {
          unidadesSelecionadas.add(value[i].id);
        }
      });
    });
  }

  FutureBuilder<List<UnidadeCurricular>> listView() {
    return FutureBuilder<List<UnidadeCurricular>>(
      future: fetchAllUnidadesFromAPI(widget.user.codigo),
      builder: (BuildContext context,
          AsyncSnapshot<List<UnidadeCurricular>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          if (snapshot.error is TimeoutException) {
            return const Text('Tempo de conexão excedido');
          }
          return Text('Erro ao recolher os dados: ${snapshot.error}');
        } else if (snapshot.hasData) {
          List<UnidadeCurricular> unidades = snapshot.data!;
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: anos.length,
              itemBuilder: (BuildContext context, int index) {
                return ExpansionTile(
                  textColor: primary,
                  title: Text(
                    tituloTile(anos[index]),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  children: [
                    ListView.builder(
                      controller: ScrollController(keepScrollOffset: true),
                      shrinkWrap: true,
                      itemCount: unidades.length,
                      itemBuilder: (BuildContext context, int disciplinaIndex) {
                        UnidadeCurricular aux = unidades[disciplinaIndex];
                        if (anos[index] == aux.ano) {
                          return WidgetTile(unidadeCurricular: aux);
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                );
              },
            ),
          );
        } else {
          return const Text('Dados não encontrados');
        }
      },
    );
  }

  ElevatedButton buildBotaoSubmeter(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (unidadesSelecionadas.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Center(
                  child: Text('Selecione pelo menos 1 Unidade Curricular!',
                      style: TextStyle(fontSize: 20))),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          addUCsAluno(unidadesSelecionadas, widget.user.id).then((value) {
            if (value) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Center(
                      child: Text('Submetido com sucesso',
                          style: TextStyle(fontSize: 20))),
                  backgroundColor: Colors.green,
                ),
              );
              unidadesSelecionadas.clear();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Center(
                      child: Text('Erro ao submeter',
                          style: TextStyle(fontSize: 20))),
                  backgroundColor: Colors.red,
                ),
              );
            }
          });
        }
      },
      child: Text('Submeter'),
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        listView(),
        buildBotaoSubmeter(context),
      ],
    );
  }
}

class WidgetTile extends StatefulWidget {
  final UnidadeCurricular unidadeCurricular;

  const WidgetTile({super.key, required this.unidadeCurricular});

  @override
  State<WidgetTile> createState() => _WidgetTileState();
}

class _WidgetTileState extends State<WidgetTile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Colors.grey, width: 1)),
        child: ListTile(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.menu_book_outlined,
                color: primary,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  widget.unidadeCurricular.nome,
                  style: const TextStyle(
                      letterSpacing: 1,
                      fontSize: 12,
                      overflow: TextOverflow.ellipsis),
                ),
              ),
              Checkbox(
                value:
                    unidadesSelecionadas.contains(widget.unidadeCurricular.id),
                onChanged: (selected) {
                  setState(() {
                    if (selected != null && selected) {
                      unidadesSelecionadas.add(widget.unidadeCurricular.id);
                    } else {
                      unidadesSelecionadas.remove(widget.unidadeCurricular.id);
                    }
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
