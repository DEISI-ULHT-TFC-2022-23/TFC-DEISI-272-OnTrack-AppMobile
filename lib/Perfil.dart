import 'package:flutter/material.dart';
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
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.red, Colors.black],
              ),
            ),
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
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    user.nome,
                    style: TextStyle(
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
              padding: EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 16,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Detalhes",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontStyle: FontStyle.normal,
                      fontSize: 28,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text("Email: ${user.email}"),
                  SizedBox(height: 10,),
                  Text("Ano: ${user.ano}º"),
                  SizedBox(height: 10,),
                  Text("Ects: ${user.ects}/180"),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
