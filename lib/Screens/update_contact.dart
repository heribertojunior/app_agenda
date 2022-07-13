import 'package:app_agenda/Models/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_it/get_it.dart';

import '../BD/contact_table.dart';

class UpdateContact extends StatefulWidget {
  const UpdateContact({Key? key, required this.onUpdateList, required this.c})
      : super(key: key);
  //função de callback (uma função passada como parametro)
  final VoidCallback onUpdateList;
  final Contact c;
  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  final name = TextEditingController();
  final phone = TextEditingController();
  var db = GetIt.I.get<ContactTable>();

  _updtContact() async {
    var c = Contact(id: widget.c.id, name: name.text, phone: phone.text);
    await db.updateContact(c);
    widget.onUpdateList();
    Navigator.of(context).pop();
  }

  _dltContact() async {
    await db.deleteContact(widget.c.id);
    widget.onUpdateList();
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name.text = widget.c.name;
    phone.text = widget.c.phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alterar contato"),
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
                  child: Text("Alertar"),
                  onPressed: () {
                    _updtContact();
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  child: Text("Remover"),
                  onPressed: () {
                    _dltContact();
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
