import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tfc_ontack/EventoAvaliacao.dart';
import 'package:tfc_ontack/User.dart';

import '../UnidadeCurricular.dart';


const _servidorOnTrackAPIEndpoint = 'http://192.168.1.70:8080/api/v1';

Future<List<UnidadeCurricular>> fetchUnidadesFromAPI(int userID) async {
  final response = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/aluno/$userID/unidades-curriculares/list'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    List<UnidadeCurricular> unidades = [];
    for (var unidadeData in data) {
      UnidadeCurricular unidade = UnidadeCurricular.fromJson(unidadeData);
      unidades.add(unidade);
    }
    return unidades;
  } else {
    throw Exception('Erro ao buscar unidades da API');
  }
}

Future<User> fetchUserFromAPI(String id) async {
  var idAluno = id;

  var response = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/aluno/$idAluno'));
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    User user = User.fromJson(jsonResponse);
    return user;
  } else {
    throw Exception('Erro ao buscar user da API');
  }
}

Future<List<EventoAvaliacao>> fetchAvaliacoesFromAPI(int id) async {
  final response = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/unidade_curricular/$id/avaliacoes/list'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    List<EventoAvaliacao> avaliacoes = [];
    for (var avaliacaoData in data) {
      EventoAvaliacao unidade = EventoAvaliacao.fromJson(avaliacaoData);
      avaliacoes.add(unidade);
    }
    return avaliacoes;
  } else {
    throw Exception('Erro ao buscar avaliações da API');
  }
}
Future<List<EventoAvaliacao>> fetchAllAvaliacoesFromAPI() async {
  final response = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/avaliacao/list'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    List<EventoAvaliacao> avaliacoes = [];
    for (var avaliacaoData in data) {
      EventoAvaliacao unidade = EventoAvaliacao.fromJson(avaliacaoData);
      avaliacoes.add(unidade);
    }
    return avaliacoes;
  } else {
    throw Exception('Erro ao buscar avaliações da API');
  }
}

Future<List<UnidadeCurricular>> fetchAllUnidadesFromAPI(int idCurso) async {
  final response = await http.get(Uri.parse('${_servidorOnTrackAPIEndpoint}/curso/$idCurso/unidades-curriculares/list'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    List<UnidadeCurricular> unidades = [];
    for (var unidadeData in data) {
      UnidadeCurricular unidade = UnidadeCurricular.fromJson(unidadeData);
      unidades.add(unidade);
    }
    return unidades;
  } else {
    throw Exception('Erro ao buscar todas as unidades da API');
  }
}

Future<bool> addUCsAluno(List<int> ucIds, int id) async {
  var idAluno = id;

  for(int id in ucIds) {
    var response = await http.post(Uri.parse('${_servidorOnTrackAPIEndpoint}/aluno/${idAluno}/unidades-curriculares/add/$id'));
    if (response.statusCode == 200) {
      print('Unidade curricular adicionada com sucesso.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return false;
    }
  }
  return true;
}

Future<int> login(String email, String password) async {
  var body = jsonEncode(<String, String>{
    'email': email,
    'password': password,
  });
  var url = '$_servidorOnTrackAPIEndpoint/login';
  var response = await http.post(Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: body,
  );
  if (response.statusCode == 200) {
    var jsonResponse = jsonDecode(response.body);
    return jsonResponse['id'];
  } else {
    throw Exception('Request failed with status: ${response.statusCode}.');
  }
}