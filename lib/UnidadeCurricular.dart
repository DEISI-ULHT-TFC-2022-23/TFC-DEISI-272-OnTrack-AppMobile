import 'EventoAvaliacao.dart';

class UnidadeCurricular {
  late String nome;
  late String docenteTeoricas;
  late String docentePraticas;
  late int ano;
  late int semestre;
  late int ects;
  late List eventosDeAvaliacao = [
    EventoAvaliacao(
        unidadeCurricular: UnidadeCurricular(
            nome: "Computação Móvel",
            docenteTeoricas: "Pedro Alves",
            docentePraticas: "Miguel Tavares",
            ano: 3,
            semestre: 2,
            ects: 5),
        tipoDeEvento: "Projeto",
        metodoDeEntrega: "Drop Project",
        dateTime: DateTime(2023, 5, 15, 18, 30)),
    EventoAvaliacao(
        unidadeCurricular: UnidadeCurricular(
            nome: "Computação Móvel",
            docenteTeoricas: "Pedro Alves",
            docentePraticas: "Miguel Tavares",
            ano: 3,
            semestre: 2,
            ects: 5),
        tipoDeEvento: "Ficha Prática",
        metodoDeEntrega: "Drop Project",
        dateTime: DateTime(2023, 4, 15, 18, 30))
  ];

  UnidadeCurricular(
      {required this.nome,
      required this.docenteTeoricas,
      required this.docentePraticas,
      required this.ano,
      required this.semestre,
      required this.ects});
}
