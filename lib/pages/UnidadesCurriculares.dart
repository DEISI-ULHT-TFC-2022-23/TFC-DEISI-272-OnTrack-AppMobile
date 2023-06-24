import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tfc_ontack/User.dart';
import 'package:tfc_ontack/static/Colors/Colors.dart';
import 'package:tfc_ontack/UnidadeCurricular.dart';

import '../services/api_requests.dart';
import 'DetalhesUnidadeCurricular.dart';

class UnidadesCurriculares extends StatefulWidget {
  User user;

  UnidadesCurriculares(this.user, {Key? key}) : super(key: key);

  @override
  State<UnidadesCurriculares> createState() => _UnidadesCurricularesState();
}

class _UnidadesCurricularesState extends State<UnidadesCurriculares> {
  List<int> semestres = [1, 2, 3];

  String tituloTile(int semestre) {
    if (semestre == 1) {
      return "1ºSemestre";
    } else if (semestre == 2) {
      return "2ºSemestre";
    } else {
      return "Anual";
    }
  }

  FutureBuilder<List<UnidadeCurricular>> listView() {
    return FutureBuilder<List<UnidadeCurricular>>(
      future: fetchUnidadesFromAPI(widget.user.id),
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
          return ListView.builder(
            itemCount: semestres.length,
            itemBuilder: (BuildContext context, int index) {
              return ExpansionTile(
                textColor: primary,
                title: Text(
                  tituloTile(semestres[index]),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                children: [
                  ListView.builder(
                    controller: ScrollController(keepScrollOffset: true),
                    shrinkWrap: true,
                    itemCount: unidades.length,
                    itemBuilder: (BuildContext context, int disciplinaIndex) {
                      Color borda = Colors.grey;
                      UnidadeCurricular aux = unidades[disciplinaIndex];
                      if (semestres[index] == aux.semestre) {
                        return WidgetTile(borda: borda, unidadeCurricular: aux, context: context);
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              );
            },
          );
        } else {
          return const Text('Dados não encontrados');
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: listView(),
    );
  }
}

class WidgetTile extends StatefulWidget {
  UnidadeCurricular unidadeCurricular;
  Color borda;
  BuildContext context;

  WidgetTile({super.key, required this.borda, required this.unidadeCurricular, required this.context});

  @override
  State<WidgetTile> createState() => _WidgetTileState();
}

class _WidgetTileState extends State<WidgetTile> {

  Text buildTextSemestre(UnidadeCurricular aux) {
    UnidadeCurricular x = aux;
    String texto = "";
    if (x.semestre == 1) {
      texto = "1º Semestre";
    } else if (aux.semestre == 2) {
      texto = "2º Semestre";
    } else {
      texto = "Anual";
    }
    return Text(
      texto,
      style: const TextStyle(
        letterSpacing: 1,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: SizedBox(
        height: 65,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: widget.borda, width: 1)),
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
                buildTextSemestre(widget.unidadeCurricular),
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
              ],
            ),
            onTap: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetalhesUnidadeCurricular(
                      unidadeCurricular: widget.unidadeCurricular,
                    ),
                  ),
                );
              });
            },
          ),
        ),
      ),
    );
  }
}
