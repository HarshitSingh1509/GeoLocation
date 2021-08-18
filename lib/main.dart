import 'package:flutter/material.dart';
import 'package:flutter_application_1/idtaker.dart';
import 'package:flutter_application_1/reciever.dart';
import 'package:flutter_application_1/sender.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'GPS DEMO PROJECT'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 
  @override
  Widget build(BuildContext context) {
   

    return Scaffold(
      appBar: AppBar(
 
        title: Text(widget.title),
       
      ),
      body:Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[Container(
          width: 200,
          color: Colors.blue,
          child: TextButton(
     child: Text("Sender"), style:  TextButton.styleFrom(
          primary: Colors.black,
    ), onPressed:  () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Sender()),
  );
}
    ,),
        ),
        SizedBox(height: 30,),
        Container(
          width: 200,
          color: Colors.blue,
          child: TextButton(onPressed:  () {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => IdTaker()),
  );
}, child: Text("Reciever"), style:  TextButton.styleFrom(
          primary: Colors.black,
    ),),
        )],),
      )
     
     
    );
  }
}
