import 'package:flutter/material.dart';
import 'package:tfc_ontack/UnidadeCurricular.dart';

class DetalhesUnidadeCurricular extends StatefulWidget {
  UnidadeCurricular x;

  DetalhesUnidadeCurricular({Key? key, required this.x}) : super(key: key);

  @override
  State<DetalhesUnidadeCurricular> createState() =>
      _DetalhesUnidadeCurricularState(x);
}

class _DetalhesUnidadeCurricularState extends State<DetalhesUnidadeCurricular> {
  UnidadeCurricular x;

  _DetalhesUnidadeCurricularState(this.x);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes de Unidade Curricular'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    x.nome,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                const Icon(Icons.people, color: Colors.blue),
                const SizedBox(width: 5),
                Text(
                  'Docente teoricas: ${x.docenteTeoricas}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Icon(Icons.people, color: Colors.blue),
                const SizedBox(width: 5),
                Text(
                  'Docente práticas: ${x.docentePraticas}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Icon(Icons.book, color: Colors.blue),
                const SizedBox(width: 5),
                Text(
                  'Disciplina do ${x.ano}ºAno, ${x.semestre}ºSemestre',
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Icon(Icons.grade, color: Colors.amber),
                const SizedBox(width: 5),
                Text(
                  "ECTS: ${x.ects}",
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Center(
              child: Text(
                "Eventos de avaliação",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (context, index) {
                  Color borda = Colors.grey;

                  return SizedBox(
                    height: 65,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: borda, width: 1)),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            children: const [
                              Text(
                                "05/01/2023",
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(width: 20,),
                              Text(
                                "Ficha prática",
                                style: TextStyle(fontSize: 14),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          setState(() {});
                        },
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
