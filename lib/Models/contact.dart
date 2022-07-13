class Contact {
  late int id;
  late String name;
  late String phone;

  Contact({required this.id, required this.name, required this.phone});

// Metodo para transformar em Map o objto
  Map<String, dynamic> toMap() {
    //o if(id != 0) ta ai pra quando eu for alterar um contato n precisar fazer outro tomap
    return {'name': name, 'phone': phone, if (id != 0) 'id': id};
  }

  //Metodo para transformar de Map para Objt
  Contact.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    phone = map['phone'];
    id = map['id'];
  }
}
