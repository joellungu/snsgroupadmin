import 'package:adminsnsgroup/details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'User.dart';
import 'main.dart';


class Accueil extends StatefulWidget{

  Firestore firestore;
  Accueil(this.firestore);

  @override
  State<StatefulWidget> createState() {
    return _Accueil();
  }

}

class _Accueil extends State<Accueil>{


  List<User> utilisateursListe = List<User>();

  @override
  void initState() {
    super.initState();
    //
      utilisateursListe.clear();
    //
    widget.firestore
      .collection('utilisateur')
      .where("ids", isEqualTo: "client")
      .snapshots()
      .listen((data) =>
        data.documents.forEach((doc){

          //List<String> lis = recherche.text.split(" ");
            //doc["nom"].toUpperCase() == lis[0].toUpperCase() || doc["postnom"].toUpperCase() == lis[1].toUpperCase()
          if(true){
            print("salut");
            setState(() {
              utilisateursListe.add(
                User(
                  nom: doc["nom"],
                  postnom: doc["postnom"],
                  province: doc["province"],
                  adresse: doc["adresse"],
                  email: doc["email"],
                  company: doc["prenom"],
                  ville: doc["ville"],
                  numero: doc["numero"],
                  mac: doc["mac"]
                )
              );
            });
          }else{
            
          }
        }
      )
    );
  
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Users",
            style: TextStyle(
              color: Colors.white
            ),
          ),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: utilisateursListe.length,
          itemBuilder: (BuildContext context, t){
            return InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context){
                    return Details(utilisateursListe[t],widget.firestore);
                  }
                ));
              },
              child: Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Container(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Container(
                          color: Colors.white,
                          child: Center(
                            child: Container(
                              height: 50,
                              width: 50,
                              child: Center(
                                child: Icon(Icons.person, size: 40, color: Colors.white),
                              ),
                              decoration: BoxDecoration(
                                color: couleurP,
                                borderRadius: BorderRadius.circular(25)
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 8,
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text("${utilisateursListe[t].nom}")
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text("${utilisateursListe[t].email}")
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ),
            );
          }
        ),
      ), 
      onWillPop: () => Future.value(false)
    );
  }

}