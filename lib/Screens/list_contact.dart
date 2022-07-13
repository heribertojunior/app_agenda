import 'package:app_agenda/BD/contact_table.dart';
import 'package:app_agenda/Models/contact.dart';
import 'package:app_agenda/Screens/insert_contact.dart';
import 'package:app_agenda/Screens/update_contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get_it/get_it.dart';

class ListData extends StatefulWidget {
  const ListData({Key? key}) : super(key: key);

  @override
  State<ListData> createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  var bd = GetIt.I.get<ContactTable>();
  late Future<List<Contact>> items;

  @override
  void initState() {
    super.initState();
    items = bd.getContacts();
  }

  updateData() {
    setState(() {
      items = bd.getContacts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contatos")),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 400,
                width: double.infinity,
                child: FutureBuilder<List<Contact>>(
                  //diz a variavel que alimenta a lista
                  future: items,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Contact> data = snapshot.data!;

                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(data[index].name),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UpdateContact(
                                              onUpdateList: updateData,
                                              c: data[index],
                                            )));
                              },
                            );
                          });
                    } else if (snapshot.hasError) {
                      Text("${snapshot.error}");
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text("Novo Contato"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  InsertContact(onUpdateList: updateData)));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
