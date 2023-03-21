import 'package:flutter/material.dart';
import 'package:tfc_ontack/EventoAvaliacao.dart';

class DetalhesEventoAvaliacao extends StatefulWidget {
  EventoAvaliacao eventoAvaliacao;

  DetalhesEventoAvaliacao({Key? key, required this.eventoAvaliacao})
      : super(key: key);

  @override
  State<DetalhesEventoAvaliacao> createState() =>
      _DetalhesEventoAvaliacaoState(eventoAvaliacao);
}

class _DetalhesEventoAvaliacaoState extends State<DetalhesEventoAvaliacao> {
  EventoAvaliacao eventoAvaliacao;

  _DetalhesEventoAvaliacaoState(this.eventoAvaliacao);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes de Evento de Avaliação'),
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
                Text(
                  'Unidade curricular: ${eventoAvaliacao.unidadeCurricular.nome}',
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
                  'Horário: ${eventoAvaliacao.dateTime.day}/${eventoAvaliacao.dateTime.month}/${eventoAvaliacao.dateTime.year} ${eventoAvaliacao.dateTime.hour}:${eventoAvaliacao.dateTime.minute}',
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
                  "Tempo até ao evento: 2Dias",
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
