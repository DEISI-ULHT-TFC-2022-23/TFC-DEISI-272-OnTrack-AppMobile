import 'package:flutter/material.dart';

import 'Colors/Colors.dart';
import 'Notificacao.dart';

class Notificacoes extends StatefulWidget {
  const Notificacoes({Key? key}) : super(key: key);

  @override
  State<Notificacoes> createState() => _NotificacoesState();
}

List<Notificacao> notificacoes = [
  Notificacao(titulo: "TFC", mensagem: "Entrega de projeto daqui a 2 dias", data: "25/04/2023", hora: "12:00", id: 1),
  Notificacao(titulo: "IHM", mensagem: "Frequencia daqui a 4 dias", data: "27/04/2023", hora: "12:00", id: 2),
  Notificacao(titulo: "CM", mensagem: "Defesa de projeto na próxima semana", data: "3/05/2023", hora: "12:00", id: 3),
  ];

class _NotificacoesState extends State<Notificacoes> {
  ListView _buildListView() {
    return ListView.builder(
      itemCount: notificacoes.length,
      itemBuilder: (context, index) {
        Notificacao a = notificacoes[index];
        return Card(
          child: ListTile(
            title: Text(notificacoes[index].titulo, style: TextStyle(fontWeight: FontWeight.bold, color: primary, overflow: TextOverflow.ellipsis),),
            subtitle: Text(notificacoes[index].mensagem),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("${notificacoes[index].data}",),
                Text("${notificacoes[index].hora}"),
              ],
            ),
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
