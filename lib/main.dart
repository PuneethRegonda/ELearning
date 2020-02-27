import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Widget> _screensList = [];
  int _counterIndex;
  @override
  void initState() {
    super.initState();
    _counterIndex = 0;
    _screensList.add(NewsFeed());
    _screensList.add(AccessScreen());
    _screensList.add((Admin()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Attedance',
      home: Scaffold(
        appBar: AppBar(
          title: Text('E-Attendance'),
        ),
        body: _screensList[_counterIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            setState(() {
              _counterIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                title: Text("Feeds"), icon: Icon(Icons.assignment)),
            BottomNavigationBarItem(
                title: Text("Access"), icon: Icon(Icons.apps)),
            BottomNavigationBarItem(
                title: Text("Admin"), icon: Icon(Icons.person)),
          ],
          currentIndex: _counterIndex,
        ),
      ),
    );
  }
}

class NewsFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Card(
            elevation: 0.5,
            child: ListTile(
              title: Text("E-Learnong form Google"),
            ),
          ),
          Card(
            elevation: 0.5,
            child: ListTile(
              title: Text("Latest Library BLoC"),
            ),
          ),
          Card(
            elevation: 0.5,
            child: ListTile(
              title: Text("E-Learnong"),
            ),
          ),
          Card(
            elevation: 0.5,
            child: ListTile(
              title: Text("priya"),
            ),
          ),
        ],
      ),
    );
  }
}

class AccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Container(
      margin: EdgeInsets.all(28.0),
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
                hintText: "Email", border: OutlineInputBorder()),
          ),

          SizedBox(height: 2-.0,),
          TextFormField(
            decoration: InputDecoration(
                hintText: "Password", border: OutlineInputBorder()),
          ),
          SizedBox(height: 2-.0,),
          RaisedButton(onPressed: () {},child: Text("Resume"),)
        ],
      ),
    ));
  }
}

class Admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Admin Screen"));
  }
}
