import 'package:flutter/material.dart';
import 'package:tfc_ontack/pages/LoginToken.dart';
import 'package:tfc_ontack/static/Colors/Colors.dart';
import 'package:tfc_ontack/navigation/Pages.dart';

import '../User.dart';
import '../services/api_requests.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    var id = await login(email, password);

    _passwordController.clear();

    User user = await fetchUserFromAPI(id.toString());
    Navigator.push(context, MaterialPageRoute(builder: (context) => Pages(user: user,))); //Trocar pelo id vindo ao API
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/login_background.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 150,
              ),
              Title(
                color: Colors.black,
                child: const Text(
                  "OnTrack",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                      color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildEmail(),
                    const SizedBox(
                      height: 20.0,
                    ),
                    buildPassword(),
                    const SizedBox(
                      height: 30,
                    ),
                    buildSubmit(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox buildSubmit() {
    return SizedBox(
      height: 80,
      width: 80,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: FloatingActionButton(
          backgroundColor: primary,
          child: const Text(
            "Entrar",
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          onPressed: () {
            _submit();
          },
        ),
      ),
    );
  }

  Padding buildPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        controller: _passwordController,
        decoration: const InputDecoration(
          hintStyle: TextStyle(
            color: Colors.grey,
            fontFamily: "WorkSansLight",
            fontSize: 15.0,
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: "Senha",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(90.0)),
              borderSide: BorderSide(
                color: Colors.white24,
                width: 0.5,
              )),
          prefixIcon: Icon(
            Icons.lock_outline,
            color: Colors.grey,
          ),
        ),
        obscureText: true,
        validator: (text) {
          if (text!.isEmpty || text.length < 6) {
            return "Senha inválida!";
          }
        },
      ),
    );
  }

  Padding buildEmail() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        controller: _emailController,
        decoration: const InputDecoration(
          hintStyle: TextStyle(
              color: Colors.grey, fontFamily: "WorkSansLight", fontSize: 15.0),
          filled: true,
          fillColor: Colors.white,
          hintText: "E-mail",
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(90.0)),
              borderSide: BorderSide(color: Colors.white24, width: 0.5)),
          prefixIcon: Icon(
            Icons.email,
            color: Colors.grey,
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (text) {
          if (text!.isEmpty || !text.contains("@")) {
            return "E-mail inválido!";
          }
        },
      ),
    );
  }
}
