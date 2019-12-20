import 'dart:convert';

import 'package:flutter_api_crud/services/services/endpoints.dart';
import 'package:http/http.dart';
import 'package:flutter_api_crud/model/post.dart';
import 'dart:async';

class Services {
  // * get post API call
  static Future<List<PostModel>> requestGet() async {
    Response response = await get(APIs.get_posts);
    try {
      if (response.statusCode == 200) {
        List<PostModel> list;
        if (response.body != "" && response.body.toString() != "[]") {
          // final parsed =
          //     json.decode(response.body).cast<Map<String, dynamic>>();
          // list = parsed
          //     .map<PostModel>((json) => PostModel.fromJson(json))
          //     .toList();

          list = postFromJson(response.body);
        }
        return list;
      } else {
        throw Exception(MESSAGES.INTERNET_ERROR);
      }
    } catch (e) {
      throw Exception(MESSAGES.INTERNET_ERROR);
    }
  }

// * Save post API call
  static Future<bool> requestSavePost(PostModel _post) async {
    // Map<String, String> header = {"Content-type": "application/json"};
    Map<String, String> header = {
      'Content-type': 'application/json',
    };
    String body = postToJson(_post);
    Response res = await post(APIs.save_post, headers: header, body: body);
    if (res.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

// * Delete post API call
  static Future<bool> deletePost(int id) async {
    Response res = await delete(APIs.delete_post + '$id');

    if (res.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
