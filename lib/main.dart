import 'dart:convert';

import 'package:eattendace/feed_web_view.dart';
import 'package:eattendace/urls/urls.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'exceptions.dart';
import 'models.dart';

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
  Future<List<Feeds>> getFeeds() async {
    List<Feeds> feedsList = [];
    await http.get(Urls.feeds).then((http.Response response) {
      print(response.statusCode);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        data.forEach((String a, dynamic map) {
          // print(map);
          Feeds feed = Feeds.fromJson(map);
          // print(feed.toString());
          feedsList.add(feed);
        });
      }
      print(feedsList);
    });
    return feedsList;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Feeds>>(
      future: getFeeds(),
      builder: (BuildContext context, AsyncSnapshot<List<Feeds>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return Center(child: CircularProgressIndicator());
            break;
          case ConnectionState.done:
            print(snapshot.data);
            if (snapshot.data != null) {
              return buildFeeds(snapshot.data);
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Somethin Went wrong"),
              );
            } // debugPrint(snapshot.error);
            break;
        }
        return Container(
          color: Colors.red,
          width: double.infinity,
          height: 500.0,
        );
      },
    );
  }

  Widget buildFeeds(List<Feeds> list) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, int index) {
          return buildFeedCard(list[index], context);
        });
  }

  InkWell buildFeedCard(Feeds feed, BuildContext context) {
    print("Runnning");
    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => MyWebView(
                    title: feed.title,
                    selectedUrl: feed.url,
                  )));
        },
        child: Card(
          child: SizedBox(
              height: 70.0, width: double.infinity, child: Text(feed.title)),
        ));
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
          SizedBox(
            height: 2 - .0,
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: "Password", border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 2 - .0,
          ),
          RaisedButton(
            onPressed: () {
              print("Login");
            },
            child: Text("Login "),
          )
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
