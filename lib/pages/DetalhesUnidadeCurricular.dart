import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tfc_ontack/services/api_requests.dart';
import 'package:tfc_ontack/static/Colors/Colors.dart';
import 'package:tfc_ontack/UnidadeCurricular.dart';

import '../EventoAvaliacao.dart';
import 'DetalhesEventoAvaliacao.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes de Unidade Curricular'),
        backgroundColor: primary,
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
                    unidadeCurricular.nome,
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                    softWrap: true,
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
                  'Professor/a: ${unidadeCurricular.professor}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            /*
            const SizedBox(height: 15),
            Row(
              children: [
                const Icon(Icons.people, color: Colors.blue),
                const SizedBox(width: 5),
                Text(
                  'Docente práticas: ${unidadeCurricular.docentePraticas}',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),*/
            const SizedBox(height: 15),
            Row(
              children: [
                const Icon(Icons.book, color: Colors.blue),
                const SizedBox(width: 5),
                Text(
                  'Disciplina do ${unidadeCurricular.ano}ºAno, ${unidadeCurricular.semestre}ºSemestre',
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
              child: listView(),
            )
          ],
        ),
      ),
    );
  }

  FutureBuilder<List<EventoAvaliacao>> listView() {
    return FutureBuilder<List<EventoAvaliacao>>(
      future: fetchAvaliacoesFromAPI(unidadeCurricular.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erro ao buscar as avaliações: ${snapshot.error}');
        } else if (snapshot.hasData) {
          List<EventoAvaliacao> avaliacoes = snapshot.data!;
          return ListView.builder(
            itemCount: avaliacoes.length,
            itemBuilder: (context, index) {
              Color borda = Colors.grey;
              EventoAvaliacao avaliacao = avaliacoes[index];
              Icon realizado;
              if(avaliacao.getRealizado()){
                realizado = const Icon(Icons.check, color: Colors.green,);
              }else{
                realizado = const Icon(Icons.close, color: Colors.red,);
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
                            builder: (context) => DetalhesEventoAvaliacao(
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
          return Text('Dados não encontrados');
        }
      },
    );
  }
}
