
import 'package:flutter/material.dart';
import 'package:tfc_ontack/static/Colors/Colors.dart';
import 'package:tfc_ontack/Avaliacao.dart';

class DetalhesAvaliacao extends StatefulWidget {
  Avaliacao eventoAvaliacao;

  DetalhesAvaliacao({Key? key, required this.eventoAvaliacao})
      : super(key: key);

  @override
  State<DetalhesAvaliacao> createState() =>
      _DetalhesAvaliacaoState(eventoAvaliacao);
}

class _DetalhesAvaliacaoState extends State<DetalhesAvaliacao> {
  Avaliacao eventoAvaliacao;

  _DetalhesAvaliacaoState(this.eventoAvaliacao);

  @override
  Widget build(BuildContext context) {
    final dataOutput = eventoAvaliacao.dateTime.isAfter(DateTime.now()) ? '${eventoAvaliacao.dateTime.difference(DateTime.now()).inDays} dias' : 'Terminada';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Avaliação'),
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
                    eventoAvaliacao.tipoDeEvento,
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
                const Icon(Icons.class_, color: Colors.orange),
                const SizedBox(width: 5),
                Expanded(
                  child: Text(
                    'Unidade curricular: ${eventoAvaliacao.unidadeCurricular.nome}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                    softWrap: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Icon(Icons.input, color: Colors.orange),
                const SizedBox(width: 5),
                Text(
                  'Método de entrega: ${eventoAvaliacao.metodoDeEntrega}',
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
                const Icon(Icons.date_range, color: Colors.orange),
                const SizedBox(width: 5),
                Text(
                  'Horário: ${eventoAvaliacao.dateTime.day}/${eventoAvaliacao.dateTime.month}/${eventoAvaliacao.dateTime.year} ${eventoAvaliacao.hora}',
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Icon(Icons.update_sharp, color: Colors.red),
                const SizedBox(width: 5),
                Text(
                  "Tempo até ao evento: $dataOutput",
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
