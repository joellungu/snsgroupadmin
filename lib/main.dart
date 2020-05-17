
import 'package:adminsnsgroup/accueil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


MaterialColor couleurP = const MaterialColor(
  
    0xFFFBC02D,
    const <int, Color>{
      50: const Color(0xFFFBC02D),
      100: const Color(0xFFFBC02D),
      200: const Color(0xFFFBC02D),
      300: const Color(0xFFFBC02D),
      400: const Color(0xFFFBC02D),
      500: const Color(0xFFFBC02D),
      600: const Color(0xFFFBC02D),
      700: const Color(0xFFFBC02D),
      800: const Color(0xFFFBC02D),
      900: const Color(0xFFFBC02D),
    },
  );


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //
  //testB();
  //
  //WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await FirebaseApp.configure(
      name: 'test',
      options: const FirebaseOptions(
        googleAppID: '1:625812772640:android:6a28b12cd34b874f9ea945',
        gcmSenderID: '625812772640',
        apiKey: 'AIzaSyCNCYsxa1GDK4De13l8GGWgd2ojhdsaEJU',
        projectID: 'testfcm-96e22',
      ),
    );
    final Firestore firestore = Firestore(app: app);
  //

  runApp(MyApp(firestore));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  Firestore firestore;
  MyApp(this.firestore);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SNSGROUP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: couleurP,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(firestore,title: 'LOGIN'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage(this.firestore,{Key key, this.title}) : super(key: key);

  final String title;
  Firestore firestore;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  TextEditingController textEmail = TextEditingController();
  TextEditingController textMotdepasse = TextEditingController();
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("SNSGROUP ADMIN"),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 250,
              color: Colors.white,
              child: Center(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: ExactAssetImage("assets/app splash.png"),
                      fit: BoxFit.fill
                    )
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 50,
                right: 50
              ),
              height: 50,
              child: TextField(
                controller: textEmail,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person)
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                left: 50,
                right: 50
              ),
              height: 50,
              child: TextField(
                controller: textMotdepasse,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock)
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              padding: EdgeInsets.only(
                left: 100,
                right: 100
              ),
              child: RaisedButton(
                elevation: 1,
                color: couleurP,
                onPressed: (){
                  validationInfo(textEmail.text, textMotdepasse.text);
                },
                child: Center(
                  child: Text("Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
        ),
      ),
    );
  }

  validationInfo(String email, String motdepasse){

    if(email.isNotEmpty && motdepasse.isNotEmpty){
      widget.firestore
        .collection('admin')
        .where("email", isEqualTo: "$email")
        .where("motdepasse", isEqualTo: "$motdepasse")
        .snapshots()
        .listen((data) =>
            data.documents.forEach((doc){
                //print(doc["nom"]);
                //print("${doc["email"]}--${user.text}");
                //print("${doc["motdepasse"]}--${mdp.text}");
                //doc["email"] == user.text && doc["motdepasse"] == mdp.text               
              if(doc["email"] == email && doc["motdepasse"] == motdepasse){
                print("salut");
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context){
                    return Accueil(widget.firestore);
                  }
                ));
              }else{
                showDialog(
                  context: context,
                  builder: (BuildContext context){
                    return AlertDialog(
                      content: Text("Erreur lors de l'enregistrement, SVP veuillez reessaier"),
                      actions: <Widget>[
                        IconButton(
                          icon: Icon(Icons.close, color: Colors.yellow.shade700,),
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  }
                );
              }
            }));
      // if(user.text == "admin" && mdp.text == "admin"){
      //   
      // }
    }else{
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            content: Text("Please some field is empty."),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.close, color: Colors.yellow.shade700,),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
      );
    }

  }

}
