import 'package:flutter/material.dart';

class Definicoes extends StatefulWidget {
  const Definicoes({Key? key}) : super(key: key);

  @override
  State<Definicoes> createState() => _DefinicoesState();
}

class _DefinicoesState extends State<Definicoes> {
  bool _notificationEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 40,),
        Row(
          children: [
            SizedBox(width: 30,),
            Text("Notificações",style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
            Switch(
                value: _notificationEnabled,
                onChanged: (bool newValue) {
                  setState(() {
                    _notificationEnabled = newValue;
                  });
                }),
          ],
        )
      ],
    );
  }
}
