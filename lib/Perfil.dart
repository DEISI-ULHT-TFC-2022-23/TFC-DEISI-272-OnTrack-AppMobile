import 'package:flutter/material.dart';
import 'package:tfc_ontack/Colors/Colors.dart';
import 'package:tfc_ontack/User.dart';

class Perfil extends StatefulWidget {
  User user;

  Perfil(this.user, {Key? key}) : super(key: key);

  @override
  State<Perfil> createState() => _PerfilState(user);
}

class _PerfilState extends State<Perfil> {
  User user;

  _PerfilState(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        children: [
          Container(
            color: primary,
            child: Container(
              width: double.infinity,
              height: 175,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundImage: Image.asset(user.foto).image,
                    radius: 60,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    user.nome,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Detalhes",
                    style: TextStyle(
                      color: Color(0xFFCA0944),
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    children: [
                      const Icon(Icons.email, color: Colors.grey,),
                      const SizedBox(width: 5,),
                      Text("Email: ${user.email}"),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, color: Colors.grey,),
                      const SizedBox(width: 5,),
                      Text("Ano: ${user.ano}º"),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      const Icon(Icons.school, color: Colors.grey,),
                      const SizedBox(width: 5,),
                      Text("Curso: ${user.curso}"),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      const Icon(Icons.grade, color: Colors.amber,),
                      const SizedBox(width: 5,),
                      Text("Ects: ${user.ects}/180"),
                    ],
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
