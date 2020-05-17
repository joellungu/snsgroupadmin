import 'dart:async';
import 'package:flutter/Material.dart';

class Entite extends StatefulWidget{

  String date;
  String heure;
  String adresse;

  Entite({this.date,this.heure,this.adresse});

  

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Entite();
  }

}

class _Entite extends State<Entite>{

  String nomu = "_";

  getNom(){
    setState(() {
      getUserName(widget.adresse);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNom();
    Timer(Duration(seconds: 3),(){
      setState(() {
        getNom();
      });
    });
    //print("----------------------------------${widget.mac}");
  }

  @override
  Widget build(BuildContext context) {
    //getNom();
    
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: Colors.yellow.shade700,
          width: 0.5
        )
      ),
      child: Container(
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Center(
                      child: Icon(Icons.people, size: 35, color: Colors.yellow.shade600),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,//.grey.shade100,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    height: 40,
                    width: 40,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    child: Center(
                      child: Icon(Icons.arrow_forward_ios, color: Colors.yellow.shade700),
                    ),
                    color: Colors.white,
                    height: 35,
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 5
                    ),
                    color: Colors.white,//Colors.grey.shade100,
                    height: 60,
                    child: RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: "${widget.date} \n",
                        children: <InlineSpan>[
                          TextSpan(
                            text:"$nomu \n",
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          TextSpan(
                            text:"${widget.adresse}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontWeight: FontWeight.bold
                            ),
                          )
                        ],
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
                  ),
                )
              ],
            )
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
      ),
    );
  }

  getUserName(String mac){
    //String nom = "";
    String nom2 = "";
    
    //print("#########################$mac");
    
    // if(nom.isEmpty){
    //   //nom = nom2;
    // }
    //print("&&&&&&&&&&&&&&&&&&&&&&&$nom");
    //print("²²²²²²²²²²²²²²²²²²²²²²²$nom2");
    
    //return nom;
  }


}
