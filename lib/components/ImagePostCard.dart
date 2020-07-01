import 'package:flutter/material.dart';

import './CommentsSection.dart';

class ImagePostCard extends StatefulWidget {
  final String postId;
  final String username;
  final ImageProvider imageProvider = AssetImage("img1.jpg");
  ImagePostCard(this.postId, {this.username = "User Name"});
  @override
  _ImagePostCardState createState() =>
      _ImagePostCardState(postId, username, imageProvider);
}

class _ImagePostCardState extends State<ImagePostCard> {
  _ImagePostCardState(this.postId, this.username, this.imageProvider);
  final String postId;
  final String username;
  final ImageProvider imageProvider;

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
                    color: Theme.of(context).scaffoldBackgroundColor,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image(
                      image: imageProvider,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CommentSection(
                        postId,
                        true,
                        imageProvider: imageProvider,
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
