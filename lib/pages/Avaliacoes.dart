import 'package:flutter/material.dart';
import 'package:tfc_ontack/static/Colors/Colors.dart';
import 'package:tfc_ontack/EventoAvaliacao.dart';
import 'package:tfc_ontack/UnidadeCurricular.dart';

import 'DetalhesEventoAvaliacao.dart';

class Avaliacoes extends StatefulWidget {
  const Avaliacoes({Key? key}) : super(key: key);

  @override
  State<Avaliacoes> createState() => _AvaliacoesState();
}

List<EventoAvaliacao> eventos = [
  EventoAvaliacao(unidadeCurricular: UnidadeCurricular(nome: "Engenharia de Requisitos e Testes", docenteTeoricas: "Pedro Alves", docentePraticas: "Miguel Tavares", ano: 3, semestre: 1, ects: 5), tipoDeEvento: "Projeto", metodoDeEntrega: "Drop Project", dateTime: DateTime(2023, 3, 15, 18, 30)),
  EventoAvaliacao(unidadeCurricular: UnidadeCurricular(nome: "IHM", docenteTeoricas: "Pedro Alves", docentePraticas: "Miguel Tavares", ano: 3, semestre: 2, ects: 5), tipoDeEvento: "Defesa", metodoDeEntrega: "Presencial", dateTime: DateTime(2023, 3, 25, 18, 30)),
  EventoAvaliacao(unidadeCurricular: UnidadeCurricular(nome: "Computação Móvel", docenteTeoricas: "Pedro Alves", docentePraticas: "Miguel Tavares", ano: 3, semestre: 2, ects: 5), tipoDeEvento: "Projeto", metodoDeEntrega: "Moodle", dateTime: DateTime(2023, 4, 15, 18, 30)),
];

class _AvaliacoesState extends State<Avaliacoes> {

  ListView _buildListView() {
    return ListView.builder(
      itemCount: eventos.length,
      itemBuilder: (context, index) {
        EventoAvaliacao evento = eventos[index];
        return Card(
          child: ListTile(
            title: Text(evento.unidadeCurricular.nome, style: TextStyle(fontWeight: FontWeight.bold, color: primary, overflow: TextOverflow.ellipsis),),
            subtitle: Text(evento.tipoDeEvento),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${evento.dateTime.day}/${evento.dateTime.month}/${evento.dateTime.year}",),
                Text("${evento.dateTime.hour}:${evento.dateTime.minute}"),
              ],
            ),
            onTap: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetalhesEventoAvaliacao(
                      eventoAvaliacao: evento,
                    ),
                  ),
                );
              });
            },
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return _buildListView();
  }
}
