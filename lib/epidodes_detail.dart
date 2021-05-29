import 'package:flutter/material.dart';
import 'package:games_of_thrones/got.dart';

class EpisodesDetailPage extends StatelessWidget {
  final MyImage image;
  final List<Episodes> episodes;

  const EpisodesDetailPage(
      {Key key, @required this.image, @required this.episodes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Hero(
              tag: "got_image",
              child: CircleAvatar(
                backgroundImage: NetworkImage(image.original),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            Text("All Episodes")
          ],
        ),
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1, crossAxisCount: 2, mainAxisSpacing: 1),
          itemCount: episodes.length,
          itemBuilder: (ctx, index) => Card(
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.network(
                      episodes[index].image.medium,
                      fit: BoxFit.cover,
                      color: Colors.black.withOpacity(0.2),
                      colorBlendMode: BlendMode.darken,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            episodes[index].name,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20))),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "${episodes[index].season} - ${episodes[index].number}",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    )
                  ],
                ),
              )),
    );
  }
}
