import 'package:flutter/material.dart';
import 'package:not_sepeti/utils/database_helper.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var databaseHelper = DatabaseHelper();
    databaseHelper.kategorileriGetir().then((value) => print(value));

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
        ),
        home: NotListesi());
  }
}

class NotListesi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Not Sepeti'),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              showDialog(
                barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: Text(
                        "Kategori Ekle",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Form(
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: "Kategori Adı",
                                border: OutlineInputBorder()
                              ),
                              validator: (girilenKategoriAdi) {
                                if (girilenKategoriAdi.length < 3) {
                                  return "En az 3 karakter giriniz.";
                                }
                              },
                            ),
                          ),
                        ),
                        ButtonBar(children: [
                          RaisedButton(onPressed: (){Navigator.pop(context);}, color: Colors.deepOrangeAccent,child: Text("Vazgeç",style: TextStyle(color: Colors.white),),),
                          RaisedButton(onPressed: (){Navigator.pop(context);},color: Colors.red, child: Text("Kaydet",style: TextStyle(color: Colors.white)),)
                        ],)
                      ],
                    );
                  });
            },
            tooltip: "Kategori Ekle",
            child: Icon(Icons.add_circle),
            mini: true,
          ),
          FloatingActionButton(
            onPressed: () {},
            tooltip: "Not Ekle",
            child: Icon(Icons.add),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
