import 'UnidadeCurricular.dart';
import 'package:intl/intl.dart';

class EventoAvaliacao{
  late int id;
  late UnidadeCurricular unidadeCurricular;
  late String tipoDeEvento;
  late String metodoDeEntrega;
  late DateTime dateTime;
  late String hora;

  EventoAvaliacao({required this.id, required this.unidadeCurricular, required this.tipoDeEvento,
      required this.metodoDeEntrega, required this.dateTime, required this.hora});

  factory EventoAvaliacao.fromJson(Map<String, dynamic> json) {
    UnidadeCurricular unidadeCurricular = UnidadeCurricular.fromJson(json['unidadeCurricular']);
    String dataAvaliacaoString = json['data'];
    DateFormat inputFormat = DateFormat("dd/MM/yyyy");
    DateTime dataAvaliacao = inputFormat.parse(dataAvaliacaoString);

    return EventoAvaliacao(
      id: json['id'],
      unidadeCurricular: unidadeCurricular,
      tipoDeEvento: json['tipoDeAvaliacao'],
      metodoDeEntrega: json['metodoDeEntrega'],
      dateTime: dataAvaliacao,
      hora: json['hora']
    );
  }

  bool getRealizado(){
    return DateTime.now().isAfter(dateTime);
  }
}