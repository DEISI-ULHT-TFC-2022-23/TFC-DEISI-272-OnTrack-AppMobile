import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tfc_ontack/static/Colors/Colors.dart';
import 'package:tfc_ontack/UnidadeCurricular.dart';

import '../services/api_requests.dart';
import 'DetalhesUnidadeCurricular.dart';

class UnidadesCurriculares extends StatefulWidget {
  const UnidadesCurriculares({Key? key}) : super(key: key);

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

  /*ListView listView() {
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
              shrinkWrap: true,
              itemCount: unidades.length,
              itemBuilder: (BuildContext context, int disciplinaIndex) {
                Color borda = Colors.grey;
                UnidadeCurricular aux = unidades[disciplinaIndex];
                if (semestres[index] == aux.semestre) {
                  return buildListTile(borda, aux, context);
                } else {
                  return Container();
                }
              },
            ),
          ],
        );
      },
    );
  }*/

  FutureBuilder<List<UnidadeCurricular>> listView() {
    return FutureBuilder<List<UnidadeCurricular>>(
      future: fetchUnidadesFromAPI(),
      builder: (BuildContext context, AsyncSnapshot<List<UnidadeCurricular>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erro ao recolher os dados: ${snapshot.error}');
        } else {
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
                    shrinkWrap: true,
                    itemCount: unidades.length,
                    itemBuilder: (BuildContext context, int disciplinaIndex) {
                      Color borda = Colors.grey;
                      UnidadeCurricular aux = unidades[disciplinaIndex];
                      if (semestres[index] == aux.semestre) {
                        return buildListTile(borda, aux, context);
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              );
            },
          );
        }
      },
    );
  }



  ListTile buildListTile(Color borda, UnidadeCurricular aux, BuildContext context) {
    return ListTile(
      title: SizedBox(
        height: 65,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: borda, width: 1)),
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
                buildTextSemestre(aux),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Text(
                    aux.nome,
                    style: const TextStyle(letterSpacing: 1, fontSize: 12, overflow: TextOverflow.ellipsis),
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
                      unidadeCurricular: aux,
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
    return Center(
      child: listView(),
    );
  }
}
