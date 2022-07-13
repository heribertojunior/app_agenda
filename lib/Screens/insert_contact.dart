import 'package:app_agenda/Models/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_it/get_it.dart';

import '../BD/contact_table.dart';

class InsertContact extends StatefulWidget {
  const InsertContact({Key? key, required this.onUpdateList}) : super(key: key);
  //função de callback (uma função passada como parametro)
  final VoidCallback onUpdateList;
  @override
  State<InsertContact> createState() => _InsertContactState();
}

class _InsertContactState extends State<InsertContact> {
  final name = TextEditingController();
  final phone = TextEditingController();
  var db = GetIt.I.get<ContactTable>();

  _insrtContact() async {
    var c = Contact(id: 0, name: name.text, phone: phone.text);
    await db.insertContact(c);
    widget.onUpdateList();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Novo contato"),
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Center(
          child: Column(children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "informe o nome do contato",
                ),
                controller: name,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "informe o telefone do contato",
                ),
                controller: phone,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  child: Text("Salvar"),
                  onPressed: () {
                    _insrtContact();
                  },
                ),
              ),
            ),
          ]),
        )),
      ),
    );
  }
}
