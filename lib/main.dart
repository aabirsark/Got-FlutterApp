import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:games_of_thrones/epidodes_detail.dart';
import 'package:games_of_thrones/got.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GOT got;
  var url =
      "http://api.tvmaze.com/singlesearch/shows?q=game-of-thrones&embed=episodes";

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(Uri.parse(url));
    var decoded = jsonDecode(res.body);
    got = GOT.fromJson(decoded);
    print(decoded);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Games of Thrones"),
      ),
      body: Center(
        child: got == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : MainBody(got: got),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          fetchData();
        },
      ),
    );
  }
}

class MainBody extends StatelessWidget {
  const MainBody({
    Key key,
    @required this.got,
  }) : super(key: key);

  final GOT got;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Hero(
                    tag: "got_image",
                    child: CircleAvatar(
                      radius: 60.0,
                      backgroundImage: NetworkImage(got.image.original),
                    ),
                  ),
                ),
                Text(
                  got.name,
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 25,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "Runtime ${got.runtime} hrs",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    got.summary,
                    style: TextStyle(fontWeight: FontWeight.w500),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Divider(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EpisodesDetailPage(
                                  image: got.image,
                                  episodes: got.eEmbedded.episodes,
                                )));
                  },
                  child: Text("All Episodes"),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
