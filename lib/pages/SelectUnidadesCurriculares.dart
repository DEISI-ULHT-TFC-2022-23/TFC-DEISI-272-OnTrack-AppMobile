import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tfc_ontack/UnidadeCurricular.dart';
import 'package:tfc_ontack/User.dart';
import 'package:tfc_ontack/services/api_requests.dart';

import '../static/Colors/Colors.dart';


List<int> unidadesSelecionadas = [];

class SelectUnidadesCurriculares extends StatefulWidget {
  final User user;
  SelectUnidadesCurriculares(this.user);

  @override
  _SelectUnidadesCurricularesState createState() =>
      _SelectUnidadesCurricularesState();
}

class _SelectUnidadesCurricularesState
    extends State<SelectUnidadesCurriculares> {
  bool _isFirstTimeOpeningApp = true;

  List<int> anos = [1, 2, 3];
  List<String> lei1 = [
    "Fundamentos de Física",
    "Fundamentos de Programação",
    "Matemática Discreta",
    "Sistemas Digitais",
    "Matemática I",
    "Álgebra Linear",
    "Algoritmia e Estruturas de Dados",
    "Arquitetura de Computadores",
    "Matemática II",
    "Competências Comportamentais",
    "Linguagens de Programação I",
  ];
  List<String> lei2 = [
    "Arquiteturas Avançadas de Computadores",
    "Bases de Dados",
    "Linguagens de Programação II",
    "Probabilidades e Estatística",
    "Sistemas Operativos",
    "Engenharia de Requisitos e Testes",
    "Processamento de Imagem",
    "Programação Web",
    "Redes de Computadores",
    "Sistemas de Suporte à Decisão",
  ];
  List<String> lei3 = [
    "Trabalho Final de Curso",
    "Computação Distribuída",
    "Data Science",
    "Engenharia de Software",
    "Interação Humano-Máquina",
    "Computação Móvel",
    "Inteligência Artificial",
    "Segurança Informática",
    "Sistemas de Informação na Nuvem",
  ];

  String tituloTile(int ano) {
    if (ano == 1) {
      return "1ºAno";
    } else if (ano == 2) {
      return "2ºAno";
    } else {
      return "3ºAno";
    }
  }

  int tamanhoLista(int ano) {
    if (ano == 1) {
      return lei1.length;
    } else if (ano == 2) {
      return lei2.length;
    } else {
      return lei3.length;
    }
  }

  @override
  void initState() {
    super.initState();
    //checkFirstTimeOpeningApp();
  }

  Future<void> checkFirstTimeOpeningApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTimeOpeningApp = prefs.getBool('isFirstTimeOpeningApp') ?? true;

    setState(() {
      _isFirstTimeOpeningApp = isFirstTimeOpeningApp;
    });

    if (isFirstTimeOpeningApp) {
      // Atualize o valor para indicar que a tela já foi exibida
      await prefs.setBool('isFirstTimeOpeningApp', false);
    }
  }

  FutureBuilder<List<UnidadeCurricular>> listView(){
    return FutureBuilder<List<UnidadeCurricular>>(
      future: fetchAllUnidadesFromAPI(1),
      builder: (BuildContext context, AsyncSnapshot<List<UnidadeCurricular>> snapshot){
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          if(snapshot.error is TimeoutException){
            return const Text('Tempo de conexão excedido');
          }
          return Text('Erro ao recolher os dados: ${snapshot.error}');
        } else if (snapshot.hasData) {
          List<UnidadeCurricular> unidades = snapshot.data!;
          return Stack(
            children: [
              ListView.builder(
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
              Positioned(
                bottom: 16,
                right: 16,
                child: FloatingActionButton(
                  onPressed: () {
                    // Lógica para submeter
                  },
                  child: Icon(Icons.check),
                ),
              ),
            ],
          );
        } else {
          return const Text('Dados não encontrados');
        }
      },
    );
  }

  FloatingActionButton buildBotaoSubmeter(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if(unidadesSelecionadas.isEmpty){
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Center(child: Text('Selecione pelo menos 1 Unidade Curricular!', style: TextStyle(fontSize: 20))),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          addUCsProfessor(unidadesSelecionadas, widget.user.id).then((value) {
            if(value){
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Center(child: Text('Submetido com sucesso', style: TextStyle(fontSize: 20))),
                  backgroundColor: Colors.green,
                ),
              );
              unidadesSelecionadas.clear();
            }else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Center(child: Text('Erro ao submeter', style: TextStyle(fontSize: 20))),
                  backgroundColor: Colors.red,
                ),
              );
            }
          });

        }
      },
      child: Text('Submeter'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        listView(),
        buildBotaoSubmeter(context)
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
                value: unidadesSelecionadas.contains(widget.unidadeCurricular.id),
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

