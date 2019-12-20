import 'package:flutter/material.dart';
import 'package:flutter_api_crud/model/post.dart';
import 'package:flutter_api_crud/services/services/service.dart';

class PostAdd extends StatefulWidget {
  @override
  _PostAddState createState() => _PostAddState();
}

class _PostAddState extends State<PostAdd> {
  final _title = TextEditingController();
  final _desc = TextEditingController();
  String dropdownValue;
  void savePost() async {
    var post = PostModel();
    post.title = _title.text;
    post.categories = dropdownValue;
    post.content = _desc.text;

    final res = await Services.requestSavePost(post);
    if (res == true) {
      print('post saved');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: _title,
              decoration: InputDecoration(
                hintText: 'Post Title',
                hasFloatingPlaceholder: true,
              ),
            ),
            SizedBox(height: 10),
            // ButtonTheme()
            DropdownButton<String>(
              value: dropdownValue,
              icon: Icon(Icons.arrow_downward),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.black),
              hint: Text('Select Category'),
              underline: Container(
                height: 2,
                color: Colors.grey,
              ),
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                });
              },
              items: <String>['Book', 'Fashion', 'Travel', 'News']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            TextField(
              maxLines: 3,
              controller: _desc,
              decoration: InputDecoration(
                hintText: 'Post Content',
                hasFloatingPlaceholder: true,
              ),
            ),
            SizedBox(height: 20),
            RaisedButton(
              child: Text('Save'),
              onPressed: () {
                savePost();
              },
            )
          ],
        ),
      ),
    );
  }
}
