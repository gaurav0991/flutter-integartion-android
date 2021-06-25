import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in a Flutter IDE). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Login Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var errorMsg = "";
  int _counter = 0;
  TextEditingController t1 = new TextEditingController();
  TextEditingController t2 = new TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  void showInSnackBar(String value, context) {
    _scaffoldKey.currentState!.showSnackBar(new SnackBar(
      content: new Text(value),
      backgroundColor: Colors.red,
    ));
  }

  final snackBar = SnackBar(
    content: Text('Login Successfull!'),
    backgroundColor: Colors.green,
  );

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              print("hello");
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Login",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextField(
                controller: t1,
                decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal)),
                    hintText: 'Email',
                    prefixIcon: const Icon(
                      Icons.email,
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextField(
                controller: t2,
                decoration: new InputDecoration(
                    border: new OutlineInputBorder(
                        borderSide: new BorderSide(color: Colors.teal)),
                    hintText: 'Password',
                    prefixIcon: const Icon(
                      Icons.lock,
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              color: Theme.of(context).primaryColor,
              onPressed: () async {
                print("Started");
                var data = await http.post(
                  Uri.parse(
                      "https://user-managment-system1.herokuapp.com/api/v1/auth/login"),
                  body: json.encode({"email": t1.text, "password": t2.text}),
                  headers: {
                    "content-type": "application/json",
                    "accept": "application/json",
                  },
                );
                print(data.body);
                print(data.statusCode);
                if (data.statusCode == 200) {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                } else {
                  var j = jsonDecode(data.body);
                  showInSnackBar(j["message"], context);
                }
              },
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Text(
              "New User? Register",
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
