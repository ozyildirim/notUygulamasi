import 'package:flutter/material.dart';
import 'package:not_sepeti/models/kategori.dart';
import 'package:not_sepeti/utils/database_helper.dart';

class NotDetay extends StatefulWidget {
  String baslik;
  NotDetay({this.baslik});

  @override
  _NotDetayState createState() => _NotDetayState();
}

class _NotDetayState extends State<NotDetay> {
  var formKey = GlobalKey<FormState>();
  List<Kategori> tumKategoriler;
  DatabaseHelper databaseHelper;
  int kategoriID = 1;
  int secilenOncelik = 0;
  static var _oncelik = ["Düşük", "Orta", "Yüksek"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tumKategoriler = List<Kategori>();
    databaseHelper = DatabaseHelper();
    databaseHelper.kategorileriGetir().then((kategorileriIcerenMapListesi) {
      for (Map okunanMap in kategorileriIcerenMapListesi) {
        tumKategoriler.add(Kategori.fromMap(okunanMap));
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text(widget.baslik),
        ),
        body: tumKategoriler.length <= 0
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              "Kategori:",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 12),
                            margin: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.redAccent, width: 2),
                                borderRadius:
                                    BorderRadius.all((Radius.circular(10)))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                items: kategoriItemleriOlustur(),
                                value: kategoriID,
                                onChanged: (secilenKategoriID) {
                                  setState(() {
                                    kategoriID = secilenKategoriID;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: "Not Başlığını Giriniz:",
                              labelText: "Başlık",
                              border: OutlineInputBorder()),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          maxLines: 4,
                          decoration: InputDecoration(
                              hintText: "Not İçeriğini Giriniz:",
                              labelText: "İçerik",
                              border: OutlineInputBorder()),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Öncelik: ",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 12),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.redAccent, width: 1),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                items: _oncelik.map((oncelik) {
                                  return DropdownMenuItem<int>(
                                    child: Text(
                                      oncelik,
                                      style: TextStyle(fontSize: 24),
                                    ),
                                    value: _oncelik.indexOf(oncelik),
                                  );
                                }).toList(),
                                value: secilenOncelik,
                                onChanged: (secilenOncelikID) {
                                  setState(() {
                                    secilenOncelik = secilenOncelikID;
                                  });
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RaisedButton(
                            onPressed: () {},
                            child: Text("Vazgeç"),
                            color: Colors.redAccent.shade200,
                          ),
                          RaisedButton(
                            onPressed: () {},
                            child: Text(
                              "Kaydet",
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.redAccent.shade700,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ));
  }

  List<DropdownMenuItem<int>> kategoriItemleriOlustur() {
    return tumKategoriler
        .map((kategori) => DropdownMenuItem(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  kategori.kategoriBaslik,
                  style: TextStyle(fontSize: 24),
                ),
              ),
              value: kategori.kategoriID,
            ))
        .toList(); //to list yapmamızın amacı bu türde otomatik bir liste oluşturmak ve bunu return etmek
  }
}
