import 'package:flutter/material.dart';
import 'package:tfc_ontack/Colors/Colors.dart';
import 'package:tfc_ontack/Dashboard.dart';
import 'package:tfc_ontack/UnidadesCurriculares.dart';
import 'package:tfc_ontack/User.dart';


import 'Avaliacoes.dart';
import 'Definicoes.dart';
import 'Notificacoes.dart';
import 'Perfil.dart';

class Pages extends StatefulWidget {
  const Pages({Key? key}) : super(key: key);

  @override
  State<Pages> createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  int _selectedIndex = 0;

  static User user = User("Rafael Paulo", "a22001810@alunos.ulht.pt", "Engenharia Informática","images/Me.jpg",3,140);

  static final List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    Perfil(user),
    UnidadesCurriculares(),
    Avaliacoes(),
    Notificacoes(),
    Definicoes()
  ];

  static final List<Widget> _widgetTitle = <Widget>[
    Text("Home"),
    Text("Perfil"),
    Text("Unidades Curriculares"),
    Text("Avaliações"),
    Text("Notificações"),
    Text("Definições")
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _widgetTitle.elementAt(_selectedIndex),
        backgroundColor: primary,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: <Widget>[
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: primary,
              ),
              accountName: Text(user.nome),
              accountEmail: Text(user.email),
              currentAccountPicture: CircleAvatar(
                radius: 30.0,
                backgroundImage: Image.asset(user.foto).image,
                backgroundColor: Colors.transparent,
              ),
            ),
            ListTile(
                leading: Icon(Icons.home),
                title: Text("Home"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  _onItemTapped(0);
                  Navigator.pop(context);
                }),
            ListTile(
                leading: Icon(Icons.account_circle),
                title: Text("Perfil"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  _onItemTapped(1);
                  Navigator.pop(context);
                }),
            ListTile(
                leading: Icon(Icons.school),
                title: Text("Unidades curriculares"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  _onItemTapped(2);
                  Navigator.pop(context);
                }),
            ListTile(
                leading: Icon(Icons.emoji_events),
                title: Text("Avaliações"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  _onItemTapped(3);
                  Navigator.pop(context);
                }),
            ListTile(
                leading: Icon(Icons.notifications),
                title: Text("Notificações"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  _onItemTapped(4);
                  Navigator.pop(context);
                }),
            ListTile(
                leading: Icon(Icons.settings),
                title: Text("Definições"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  _onItemTapped(5);
                  Navigator.pop(context);
                }),
            ListTile(
                leading: Icon(Icons.logout),
                title: Text("Logout"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                })
          ],
        ),
      ),
    );
  }
}
