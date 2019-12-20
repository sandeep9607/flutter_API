import 'package:flutter/material.dart';
import 'package:flutter_api_crud/model/post.dart';
import 'package:flutter_api_crud/screens/post_add.dart';
import 'package:flutter_api_crud/services/services/service.dart';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  List<PostModel> _posts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
  }

  void fetch() async {
    final res = await Services.requestGet();
    setState(() {
      _posts = res;
    });
  }

  void deletePost(int id) async {
    final res = await Services.deletePost(id);
    if (res) {
      // _posts[]
      print('deleted');
    } else {
      print('unable to delete');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post List')),
      body: Container(
        child: (_posts == null)
            ? Center(child: Text('No Data Found...'))
            : ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  PostModel post = _posts[index];
                  return Dismissible(
                      key: ObjectKey(_posts[index]),
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20.0),
                        color: Colors.red,
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.endToStart) {
                          deletePost(post.id);
                          _posts.removeAt(index);
                        }
                      },
                      direction: DismissDirection.endToStart,
                      child: Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 3),
                        child: Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width - 32,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  post.title,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.only(
                                      start: 10, top: 3),
                                  child: Text(
                                    post.categories,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Flexible(
                                  child: Text(
                                    post.content,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ));
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PostAdd()),
          ).then((val) {
            fetch();
          });
        },
      ),
    );
  }
}
