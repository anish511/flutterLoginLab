import 'package:flutter/material.dart';
import 'package:my_first_android_flutter_project/dbhelper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final dbhelper = Databasehelper.instance;

  void insertdata() async {
    Map<String,dynamic> row = {
      Databasehelper.columnID: 1,
      Databasehelper.columnName : "Patrick",
      Databasehelper.columnage : 20
    };

    final id = await dbhelper.insert(row);
    print(id);
  }

  void queryAll() async {
    var allrows = await dbhelper.queryAll();
    allrows?.forEach((element) {print(element);});
  }

  void query() async {
    var age = 18;
    var allrows = await dbhelper.query(age);
    allrows?.forEach((element) {print(element);});
  }

  TextStyle btnstyle = TextStyle(
    fontSize: 18.0,
    fontFamily: "Verdana",
  );
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Database"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
                onPressed: insertdata,
                color: Colors.purple,
                child: Text(
                  "INSERT",
                  style: btnstyle,
                ),
            ),
            RaisedButton(
              onPressed: queryAll,
              color: Colors.blue,
              child: Text(
                "Query",
                style: btnstyle,
              ),
            ),RaisedButton(
              onPressed: query,
              color: Colors.tealAccent,
              child: Text(
                "Query Specific",
                style: btnstyle,
              ),
            ),RaisedButton(
              onPressed: (){},
              color: Colors.brown,
              child: Text(
                "Update",
                style: btnstyle,
              ),
            ),RaisedButton(
              onPressed: (){},
              color: Colors.red,
              child: Text(
                "Delete",
                style: btnstyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}