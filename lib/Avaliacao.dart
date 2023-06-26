import 'UnidadeCurricular.dart';
import 'package:intl/intl.dart';

class Avaliacao{
  late int id;
  late UnidadeCurricular unidadeCurricular;
  late String tipoDeEvento;
  late String metodoDeEntrega;
  late DateTime dateTime;
  late String hora;

  Avaliacao({required this.id, required this.unidadeCurricular, required this.tipoDeEvento,
      required this.metodoDeEntrega, required this.dateTime, required this.hora});

  factory Avaliacao.fromJson(Map<String, dynamic> json) {
    UnidadeCurricular unidadeCurricular = UnidadeCurricular.fromJson(json['unidadeCurricular']);
    String dataAvaliacaoString = json['data'];
    DateFormat inputFormat = DateFormat("dd/MM/yyyy");
    DateTime dataAvaliacao = inputFormat.parse(dataAvaliacaoString);

    return Avaliacao(
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