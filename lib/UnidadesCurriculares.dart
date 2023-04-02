import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tfc_ontack/DetalhesUnidadeCurricular.dart';
import 'package:tfc_ontack/UnidadeCurricular.dart';

class UnidadesCurriculares extends StatefulWidget {
  const UnidadesCurriculares({Key? key}) : super(key: key);

  @override
  State<UnidadesCurriculares> createState() => _UnidadesCurricularesState();
}

class _UnidadesCurricularesState extends State<UnidadesCurriculares> {
  List<int> semestres = [1, 2, 3];

  List<UnidadeCurricular> unidades = [
    UnidadeCurricular(nome: "Computação Móvel", docenteTeoricas: "Pedro Alves", docentePraticas: "Miguel Tavares", ano: 3, semestre: 1, ects: 5),
    UnidadeCurricular(nome: "IHM", docenteTeoricas: "Pedro Alves", docentePraticas: "Miguel Tavares", ano: 3, semestre: 2, ects: 5),
    UnidadeCurricular(nome: "TFC", docenteTeoricas: "Miguel Tavares", docentePraticas: "Miguel Tavares", ano: 3, semestre: 3, ects: 20),
  ];

  String tituloTile(int semestre) {
    if (semestre == 1) {
      return "1ºSemestre";
    } else if (semestre == 2) {
      return "2ºSemestre";
    } else {
      return "Anual";
    }
  }

  ListView listView() {
    return ListView.builder(
        itemCount: semestres.length,
        itemBuilder: (BuildContext context, int index) {
          return ExpansionTile(
              title: Text(
                tituloTile(semestres[index]),
                style: TextStyle(fontWeight: FontWeight.bold),
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
              ]);
        });
  }

  ListTile buildListTile(
      Color borda, UnidadeCurricular aux, BuildContext context) {
    return ListTile(
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        child: SizedBox(
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
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  buildTextSemestre(aux),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    aux.nome,
                    style: TextStyle(letterSpacing: 1, fontSize: 12),
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalhesUnidadeCurricular(
                        x: aux,
                      ),
                    ),
                  );
                });
              },
            ),
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
