import 'package:app_agenda/BD/contact_table.dart';
import 'package:app_agenda/BD/database_helper.dart';
import 'package:app_agenda/Screens/list_contact.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

// injeção de dependencia com Get_it
final getIt = GetIt.instance;
void setConfiguration() {
//registrando carregamento tardio(so quando chamar), que tera uma unica instancia na memoria
  getIt.registerLazySingleton(() => DataBaseHelper());
  getIt.registerLazySingleton(() => ContactTable());
}

void main() async {
// garante que so vai realizar as operações depois que os componentes minimos forem carregados
  WidgetsFlutterBinding.ensureInitialized();
  setConfiguration();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListData(),
      debugShowCheckedModeBanner: false,
    );
  }
}
