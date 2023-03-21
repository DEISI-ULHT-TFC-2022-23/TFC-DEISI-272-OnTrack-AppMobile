import 'package:flutter/material.dart';
import 'package:tfc_ontack/DetalhesUnidadeCurricular.dart';
import 'package:tfc_ontack/UnidadeCurricular.dart';

class UnidadesCurriculares extends StatefulWidget {
  const UnidadesCurriculares({Key? key}) : super(key: key);

  @override
  State<UnidadesCurriculares> createState() => _UnidadesCurricularesState();
}

class _UnidadesCurricularesState extends State<UnidadesCurriculares> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          Color borda = Colors.grey;
          UnidadeCurricular aux = UnidadeCurricular(
              nome: "Computação Móvel",
              docenteTeoricas: "Pedro Alves",
              docentePraticas: "Miguel Tavares",
              ano: 3,
              semestre: 2,
              ects: 5);

          return SizedBox(
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
                    Text(
                      "${aux.semestre}º Semestre",
                      style: TextStyle(
                          letterSpacing: 1,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
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
          );
        },
      ),
    );
  }
}
