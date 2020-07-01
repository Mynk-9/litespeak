import 'package:flutter/material.dart';

import './CommentsSection.dart';
import './stylingcomponents/TextPostStyle.dart';

class TextPostCard extends StatefulWidget {
  final String postId;
  final String username;
  final String postText;
  TextPostCard(
    this.postId, {
    this.username = "User Name",
    this.postText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. " +
        "Pellentesque velit mi, vulputate vitae nulla et, faucibus porta lorem. " +
        "Vivamus tincidunt lacus at odio consequat luctus. " +
        "Maecenas dictum justo at dolor ultrices viverra. " +
        "Mauris vitae elit a nulla auctor tincidunt. " +
        "Praesent pretium purus et massa ullamcorper, eget mollis purus rhoncus. " +
        "Duis vitae tellus iaculis, gravida dui iaculis, lacinia sem. " +
        "Aenean placerat quam eu sem accumsan commodo. " +
        "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. " +
        "Donec condimentum nec erat ac gravida. " +
        "Proin porttitor dapibus neque sit amet commodo. " +
        "Ut ut lectus ac nunc ultrices porttitor ut sed lorem. " +
        "Sed varius et mauris vitae tempor. " +
        "Ut at magna maximus, faucibus ante eget, vulputate nisi. " +
        "Fusce egestas enim id sem vestibulum feugiat. " +
        "In posuere tellus enim, eu tincidunt quam maximus vitae. " +
        "Nulla fermentum at lacus quis aliquam. " +
        "Quisque eros metus, dignissim et magna nec, eleifend sollicitudin ante. " +
        "Duis vehicula aliquam ipsum donec.",
  });
  @override
  _TextPostCardState createState() =>
      _TextPostCardState(postId, username, postText);
}

class _TextPostCardState extends State<TextPostCard> {
  _TextPostCardState(this.postId, this.username, this.postText);
  final String postId;
  final String username;
  final String postText;

  final List<Icon> _like = [Icon(Icons.favorite_border), Icon(Icons.favorite)];
  int _likeItr = 0;
  // final Icon _comment = Icon(Icons.comment);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
      child: Card(
        elevation: 0,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Hero(
                  tag: 'commentSectionLink' + postId,
                  child: Card(
                    elevation: _likeItr == 0 ? 10 : 20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        child: Text(
                          postText,
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.fade,
                          maxLines: 10,
                          style: textPostStyle,
                        ),
                      ),
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommentSection(
                        postId,
                        false,
                        postText: postText,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.person),
                        onPressed: () {},
                      ),
                      Text(username),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: _like[_likeItr],
                        onPressed: () {
                          setState(() => _likeItr = _likeItr == 0 ? 1 : 0);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.more_horiz),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
