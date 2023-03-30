import 'package:flutter/material.dart';
import 'package:tfc_ontack/Pages.dart';

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

    
    Navigator.push(context, MaterialPageRoute(builder: (context) => Pages()));
    //final authService = AuthService();
    //try {
    //final token = await authService.login(email, password);
    // Login bem-sucedido, salvar o token e navegar para a próxima tela
    //} catch (e) {
    // Login falhou, exibir mensagem de erro
    //}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 150,),
            Title(
              color: Colors.black,
              child: const Text("OnTrack", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 36),),
            ),
            const SizedBox(height: 100,),
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
    );
  }

  SizedBox buildSubmit() {
    return SizedBox(
                  height: 80,
                  width: 80,
                  child: FloatingActionButton(
                    backgroundColor: Colors.red,
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
                          fontSize: 15.0),
                      filled: true,
                      fillColor: Colors.white24,
                      hintText: "Senha",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(90.0)),
                          borderSide:
                              BorderSide(color: Colors.white24, width: 0.5)),
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
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                    style: const TextStyle(color: Colors.black),
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(
                          color: Colors.grey,
                          fontFamily: "WorkSansLight",
                          fontSize: 15.0),
                      filled: true,
                      fillColor: Colors.white24,
                      hintText: "E-mail",
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(90.0)),
                          borderSide:
                              BorderSide(color: Colors.white24, width: 0.5)),
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
