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
                      key: Key(_posts[index].title),
                      background: Container(color: Colors.red),
                      onDismissed: (direction) {
                        if (direction == DismissDirection.endToStart) {
                          deletePost(post.id);
                          _posts.removeAt(index);
                        }
                      },
                      direction: DismissDirection.endToStart,
                      child: Center(
                        child: Text(post.title),
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
