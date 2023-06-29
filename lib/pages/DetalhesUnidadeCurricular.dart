import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tfc_ontack/services/api_requests.dart';
import 'package:tfc_ontack/static/Colors/Colors.dart';
import 'package:tfc_ontack/UnidadeCurricular.dart';

import '../Avaliacao.dart';
import 'DetalhesAvaliacao.dart';

class DetalhesUnidadeCurricular extends StatefulWidget {
  UnidadeCurricular unidadeCurricular;

  DetalhesUnidadeCurricular({Key? key, required this.unidadeCurricular}) : super(key: key);

  @override
  State<DetalhesUnidadeCurricular> createState() =>
      _DetalhesUnidadeCurricularState(unidadeCurricular);
}

class _DetalhesUnidadeCurricularState extends State<DetalhesUnidadeCurricular> {
  UnidadeCurricular unidadeCurricular;

  _DetalhesUnidadeCurricularState(this.unidadeCurricular);

  @override
  Widget build(BuildContext context) {
    String semestreAux ="";
    if(unidadeCurricular.semestre == 1){
      semestreAux = "1º Semestre";
    }else if(unidadeCurricular.semestre == 2){
      semestreAux = "2º Semestre";
    }else{
      semestreAux = "Anual";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(unidadeCurricular.nome),
        backgroundColor: primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.people, color: Colors.blue),
                const SizedBox(width: 5),
                Text(
                  'Professor/a: ${unidadeCurricular.professor}',
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
                  'Disciplina do ${unidadeCurricular.ano}ºAno, $semestreAux',
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
                  "ECTS: ${unidadeCurricular.ects}",
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Center(
              child: Text(
                "Avaliações",
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
              child: listView(),
            )
          ],
        ),
      ),
    );
  }

  FutureBuilder<List<Avaliacao>> listView() {
    return FutureBuilder<List<Avaliacao>>(
      future: fetchAvaliacoesFromAPI(unidadeCurricular.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erro ao buscar as avaliações: ${snapshot.error}');
        } else if (snapshot.hasData) {
          List<Avaliacao> avaliacoes = snapshot.data!;
          avaliacoes.sort((a, b) {
            if (a.dateTime.isBefore(DateTime.now()) && b.dateTime.isAfter(DateTime.now())) {
              return 1;
            } else if (a.dateTime.isAfter(DateTime.now()) && b.dateTime.isBefore(DateTime.now())) {
              return -1;
            } else {
              return a.dateTime.compareTo(b.dateTime);
            }
          });
          return ListView.builder(
            itemCount: avaliacoes.length,
            itemBuilder: (context, index) {
              Color borda = Colors.grey;
              Avaliacao avaliacao = avaliacoes[index];
              Icon realizado;
              if(avaliacao.getRealizado()){
                realizado = const Icon(Icons.check, color: Colors.green,);
              }else{
                realizado = const Icon(Icons.hourglass_top, color: Colors.red,);
              }

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
                        children: [
                          realizado,
                          Text(
                            "${avaliacao.dateTime.day}/${avaliacao.dateTime.month}/${avaliacao.dateTime.year}",
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(width: 20,),
                          Text(
                            avaliacao.tipoDeEvento,
                            style: const TextStyle(fontSize: 14),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetalhesAvaliacao(
                              eventoAvaliacao: avaliacao,
                            ),
                          ),
                        );
                      });
                    },
                  ),
                ),
              );
            },
          );
        } else {
          return const Text('Dados não encontrados');
        }
      },
    );
  }
}
