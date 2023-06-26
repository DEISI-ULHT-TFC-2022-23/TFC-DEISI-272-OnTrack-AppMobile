import 'package:flutter/material.dart';
import 'package:tfc_ontack/User.dart';
import 'package:tfc_ontack/static/Colors/Colors.dart';

import '../Avaliacao.dart';
import '../services/api_requests.dart';
import 'DetalhesAvaliacao.dart';

class Avaliacoes extends StatefulWidget {
  final User user;
  const Avaliacoes(this.user, {Key? key}) : super(key: key);

  @override
  State<Avaliacoes> createState() => _AvaliacoesState();
}

class _AvaliacoesState extends State<Avaliacoes> {

  FutureBuilder<List<Avaliacao>> _buildListView() {
    return FutureBuilder<List<Avaliacao>>(
      future: fetchAllAvaliacoesFromAPI(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erro ao buscar dados: ${snapshot.error}');
        } else {
          List<Avaliacao> avaliacoes = snapshot.data!;
          if (avaliacoes.isEmpty) {
            return const Center(
              child: Text(
                "Não há avaliações",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 34,
                ),
              ),
            );
          }
          List<Avaliacao> avaliacoesFuturas = avaliacoes.where((avaliacao) => avaliacao.dateTime.isAfter(DateTime.now())).toList();
          avaliacoesFuturas.sort((a, b) => a.dateTime.compareTo(b.dateTime));


          return ListView.builder(
            itemCount: avaliacoesFuturas.length,
            itemBuilder: (context, index) {
              Avaliacao avaliacao = avaliacoesFuturas[index];
              return Card(
                child: ListTile(
                  title: Text(
                    avaliacao.unidadeCurricular.nome,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: primary,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  subtitle: Text(avaliacao.tipoDeEvento),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("${avaliacao.dateTime.day}/${avaliacao.dateTime.month}/${avaliacao.dateTime.year}"),
                      Text(avaliacao.hora),
                    ],
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
