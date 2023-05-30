import 'package:flutter/material.dart';
import 'package:tfc_ontack/static/Colors/Colors.dart';
import 'package:tfc_ontack/EventoAvaliacao.dart';
import 'package:tfc_ontack/UnidadeCurricular.dart';

import '../services/api_requests.dart';
import 'DetalhesEventoAvaliacao.dart';

class Avaliacoes extends StatefulWidget {
  const Avaliacoes({Key? key}) : super(key: key);

  @override
  State<Avaliacoes> createState() => _AvaliacoesState();
}

class _AvaliacoesState extends State<Avaliacoes> {

  /*ListView _buildListView() {
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
  }*/

  FutureBuilder<List<EventoAvaliacao>> _buildListView() {
    return FutureBuilder<List<EventoAvaliacao>>(
      future: fetchAvaliacoesFromAPI(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erro ao buscar dados: ${snapshot.error}');
        } else {
          List<EventoAvaliacao> eventos = snapshot.data!;
          return ListView.builder(
            itemCount: eventos.length,
            itemBuilder: (context, index) {
              EventoAvaliacao evento = eventos[index];
              return Card(
                child: ListTile(
                  title: Text(
                    evento.unidadeCurricular.nome,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primary,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  subtitle: Text(evento.tipoDeEvento),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${evento.dateTime.day}/${evento.dateTime.month}/${evento.dateTime.year}"),
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
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return _buildListView();
  }
}
