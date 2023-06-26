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
        const SizedBox(height: 24,),
        Row(
          children: [
            const SizedBox(width: 30,),
            const Expanded(
              child: Text(
                "Notificações",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Switch(
              value: _notificationEnabled,
              onChanged: (bool newValue) {
                setState(() {
                  _notificationEnabled = newValue;
                });
              },
            ),
            const SizedBox(width: 30,),
          ],
        )
      ],
    );
  }
}
