
import 'dart:async';
import 'dart:convert';
import 'package:adminsnsgroup/Rapport.dart';
import 'package:adminsnsgroup/detailsAutre.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:http/http.dart' as http;
import 'User.dart';
import 'entite.dart';

class Details extends StatefulWidget{
  User utilisateur = User();
  Firestore firestore;

  Details(this.utilisateur,this.firestore);

  @override
  State<StatefulWidget> createState() {
    return _Details();
  }

}

class _Details extends State<Details>{


  List<Rapport> liste = List<Rapport>();

  String d1 = "";
  String d2 = "";
  

  getRapport() async {
    DateTime d = DateTime.now();
    String date = "${d.day}/${d.month}/${d.year}";

    d1 = "$date";
    d2 = '$date';

    var reponse = await http.get("https://snsgroup.herokuapp.com/snsgroup?email=${widget.utilisateur.email}&date=15/5/2020");
    if(reponse.statusCode == 200){
      //print(reponse.body);
      List<dynamic> elements = jsonDecode(reponse.body);

      List<Map<String, dynamic>> lis = List<Map<String, dynamic>>();
      for(dynamic m in elements){
        Map<String, dynamic> v = m;
        lis.add(v);
      }
      for(Map<String, dynamic> m in lis){
        print("##:$m");
        liste.add(Rapport(
          adresse: m["adresse"],
          heure: m["heure"],
          date: m["date"]
        ));
      }
    }else{

    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getRapport();
      filtre(d1, d2, widget.utilisateur.email);
    });
  }

  @override
  Widget build(BuildContext context) {

    Timer(Duration(seconds: 1), (){
      setState(() {});
    });

    return DefaultTabController(
      // The number of tabs / content sections to display.
      length: 2,
      child:Scaffold(
        appBar: AppBar(
          title: Text("Details",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey.shade300,
            tabs: [
              Tab(text: "Profile",),
              Tab(text: "Contacts"),
            ],
          ),
          leading: IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
        body: TabBarView(
          children: [
            ListView(
              children: <Widget>[
                element(Icons.person, "Name","${widget.utilisateur.nom}"),//utilisateur.nom
                element(Icons.person, "Surname","${widget.utilisateur.postnom}"),//${utilisateur.postnom}
                element(Icons.alternate_email, "email","${widget.utilisateur.email}"),//${utilisateur.email}
                element(Icons.phone_android, "Number","${widget.utilisateur.numero}"),//${utilisateur.numero}
                element(Icons.location_city, "City","${widget.utilisateur.ville}"),//${utilisateur.ville}
                element(Icons.location_on, "address","${widget.utilisateur.adresse}"),//${utilisateur.adresse}
                element(Icons.location_on, "Province","${widget.utilisateur.province}"),//${utilisateur.province}
                element(Icons.location_city, "Company","${widget.utilisateur.company}"),//${utilisateur.company}
                element(Icons.bluetooth, "Bluetooth address","${widget.utilisateur.mac}"),//${utilisateur.mac}
              ],
            ),
            Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.yellow,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Container(
                              color: Colors.white,
                              child: Center(
                                child: Text("From"),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              color: Colors.white,
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Center(
                                      child: Text("$d1"),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.date_range),
                                      onPressed: (){
                                        DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          minTime: DateTime(2018, 1, 1),
                                          maxTime: DateTime(2031, 12, 31), onChanged: (date) {
                                            print('change $date');
                                          }, onConfirm: (date) {
                                            print('confirm $date');
                                            setState(() {
                                              d1 = "${date.day}/${date.month}/${date.year}";
                                            });
                                          }, currentTime: DateTime.now(), 
                                          locale: LocaleType.fr);
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              color: Colors.white,
                              child: Center(
                                child: Text("to"),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: Container(
                              color: Colors.white,
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Center(
                                      child: Text("$d2"),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.date_range),
                                      onPressed: (){
                                        DatePicker.showDatePicker(context,
                                          showTitleActions: true,
                                          minTime: DateTime(2018, 1, 1),
                                          maxTime: DateTime(2031, 12, 31), onChanged: (date) {
                                            print('change $date');
                                          }, onConfirm: (date) {
                                            print('confirm $date');
                                            setState(() {
                                              d2 = "${date.day}/${date.month}/${date.year}";
                                              filtre(d1, d2, widget.utilisateur.email);
                                            });
                                          }, currentTime: DateTime.now(), 
                                          locale: LocaleType.fr);
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 9,
                    child: ListView.builder(
                      padding: EdgeInsets.only(
                        top: 0,
                        
                      ),
                      itemCount: liste.length,
                      itemBuilder: (BuildContext context, t){
                        return InkWell(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context){
                                return DetailsAutre("${liste[t].adresse}",widget.firestore);
                              }
                            ));
                          },
                          child: Entite(
                            date:"${liste[t].date}",
                            heure: "${liste[t].heure}",
                            adresse: "${liste[t].adresse}",),
                        );
                      },
                    ),
                  )
                ],
              )
            )
          ]
        )
      )
    );
  }

  Widget element(IconData icon, String titre, String nom){
    return Container(
      height: 80,
      child: ListTile(
        leading: Icon(icon),
        title: Text("$titre",
          style: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 13
          ),
        ),
        subtitle: Text("$nom",
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.bold
          )
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
    );
  }
  
  filtre(String date1, String date2, String email) async {
    liste.clear();
    print("https://snsgroup.herokuapp.com/snsgroup/snsgroup/select?email=$email&date1=$date1&date2=$date2");
    var reponse = await http.get("https://snsgroup.herokuapp.com/snsgroup/snsgroup/select?email=$email&date1=$date1&date2=$date2");
    if(reponse.statusCode == 200){
      //print(reponse.body);
      List<dynamic> elements = jsonDecode(reponse.body);

      List<Map<String, dynamic>> lis = List<Map<String, dynamic>>();
      for(dynamic m in elements){
        Map<String, dynamic> v = m;
        lis.add(v);
      }
      for(Map<String, dynamic> m in lis){
        print("##:$m");
        liste.add(Rapport(
          adresse: m["adresse"],
          heure: m["heure"],
          date: m["date"]
        ));
      }
    }else{

    }
    setState((){});
  }
  
}

