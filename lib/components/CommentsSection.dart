import 'package:flutter/material.dart';

import './stylingcomponents/TextPostStyle.dart';

class CommentSection extends StatefulWidget {
  final String postId;
  final ImageProvider imageProvider;
  final String postText;
  final bool isImagePost;
  CommentSection(this.postId, this.isImagePost,
      {this.imageProvider, this.postText});

  @override
  _CommentSectionState createState() =>
      _CommentSectionState(postId, isImagePost,
          imageProvider: imageProvider, postText: postText);
}

class _CommentSectionState extends State<CommentSection> {
  final String postId;
  final ImageProvider imageProvider;
  final String postText;
  final bool isImagePost;
  _CommentSectionState(this.postId, this.isImagePost,
      {this.imageProvider, this.postText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            GestureDetector(
              child: Hero(
                tag: 'commentSectionLink' + postId,
                child: Card(
                  elevation: 5,
                  shape: ContinuousRectangleBorder(),
                  color: Theme.of(context).scaffoldBackgroundColor,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: isImagePost
                      ? Image(
                          image: imageProvider,
                        )
                      : Container(
                          margin: EdgeInsets.all(15.0),
                          child: Text(
                            postText,
                            style: textPostStyle,
                          ),
                        ),
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Column(
              children: <Widget>[
                CommentBox(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
                CommentBox(
                    "Pellentesque velit mi, vulputate vitae nulla et, faucibus porta lorem."),
                CommentBox("Vivamus tincidunt lacus at odio consequat luctus."),
                CommentBox("Maecenas dictum justo at dolor ultrices viverra."),
                CommentBox("Mauris vitae elit a nulla auctor tincidunt."),
                CommentBox(
                    "Praesent pretium purus et massa ullamcorper, eget mollis purus rhoncus."),
                CommentBox(
                    "Duis vitae tellus iaculis, gravida dui iaculis, lacinia sem."),
                CommentBox("Aenean placerat quam eu sem accumsan commodo."),
                CommentBox(
                    "Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas."),
              ],
            ),
            // CommentCreator(),
          ],
        ),
      ),
    );
  }
}

class CommentBox extends StatelessWidget {
  final String comment;
  CommentBox(this.comment);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {},
          ),
          Expanded(child: Text(comment)),
        ],
      ),
    );
  }
}

class CommentCreator extends StatefulWidget {
  @override
  _CommentCreatorState createState() => _CommentCreatorState();
}

class _CommentCreatorState extends State<CommentCreator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      padding: EdgeInsets.all(5),
      child: Row(
        children: <Widget>[
          TextField(),
          FlatButton(
            onPressed: () {},
            child: Text("Send"),
          ),
        ],
      ),
    );
  }
}
