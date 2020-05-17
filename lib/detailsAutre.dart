import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'User.dart';

class DetailsAutre extends StatefulWidget{

  String adresse = "";
  
  User utilisateur = User();

  Firestore firestore;

  DetailsAutre(this.adresse,this.firestore);

  @override
  State<StatefulWidget> createState() {
    return _DetailsAutre();
  }

}

class _DetailsAutre extends State<DetailsAutre>{

  @override
  void initState() {
    super.initState();
    //
    print("Mon adresse: -- ${widget.adresse}");
    widget.firestore
      .collection('utilisateur')
      .where("ids", isEqualTo: "client")
      .where("mac", isEqualTo: "${widget.adresse}")
      .snapshots()
      .listen((data) =>
        data.documents.forEach((doc){

          //List<String> lis = recherche.text.split(" ");
            //doc["nom"].toUpperCase() == lis[0].toUpperCase() || doc["postnom"].toUpperCase() == lis[1].toUpperCase()
          if(true){
            print("salut");
            setState(() {
              widget.utilisateur = User(
                  nom: doc["nom"],
                  postnom: doc["postnom"],
                  province: doc["province"],
                  adresse: doc["adresse"],
                  email: doc["email"],
                  company: doc["prenom"],
                  ville: doc["ville"],
                  numero: doc["numero"],
                  mac: doc["mac"]
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact details",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: ListView(
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

}
