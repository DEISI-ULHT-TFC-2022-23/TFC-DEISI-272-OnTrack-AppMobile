import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tfc_ontack/pages/Login.dart';

void main() {
  getUsers();
  runApp(const MyApp());
}

Future<List<dynamic>> getUsers() async {
  final response = await http.get(Uri.parse('https://642b3d8dd7081590f91f36f2.mockapi.io/users'));
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Falha ao carregar os dados da API');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: LoginPage(),
    );
  }
}
