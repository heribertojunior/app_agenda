import 'package:app_agenda/BD/database_helper.dart';
import 'package:app_agenda/Models/contact.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

// ARQUIVO RESPONSAVEL POR GERENCIAR A TABELA

class ContactTable {
// Metodo de inserção
  Future<void> insertContact(Contact c) async {
    var db = await GetIt.I.get<DataBaseHelper>().getDB();
    //Inserindo o Map na tabela contact
    await db.insert('contact', c.toMap());
    // fechando o banco
    await db.close();
  }

//Listar
  Future<List<Contact>> getContacts() async {
    var db = await GetIt.I.get<DataBaseHelper>().getDB();
    //armazenando a querry de consulta na variavel maps
    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM contact ORDER BY name");
    // fechando o banco
    await db.close();

    //Criando uma lista retornando um map para cada elemento da lista transformando em Objt
    return List.generate(maps.length, (index) => Contact.fromMap(maps[index]));
  }

  // Metodo de update
  Future<void> updateContact(Contact c) async {
    var db = await GetIt.I.get<DataBaseHelper>().getDB();
    //alterando o Map na tabela contact
    await db.update('contact', c.toMap(), where: 'id = ?', whereArgs: [c.id]);
    // fechando o banco
    await db.close();
  }

  // Metodo de exclusão
  Future<void> deleteContact(int id) async {
    var db = await GetIt.I.get<DataBaseHelper>().getDB();
    //Inserindo o Map na tabela contact
    await db.delete('contact', where: 'id = ?', whereArgs: [id]);
    // fechando o banco
    await db.close();
  }
}
