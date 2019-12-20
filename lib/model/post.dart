import 'dart:convert';

List<PostModel> postFromJson(String response) {
  final parsed = json.decode(response).cast<Map<String, dynamic>>();
  return parsed.map<PostModel>((json) => PostModel.fromJson(json)).toList();
}

String postToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  int id;
  String title;
  String categories;
  String content;

  PostModel({
    this.id,
    this.title,
    this.categories,
    this.content,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json["id"],
        title: json["title"],
        categories: json["categories"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        // "id": id,
        "title": title,
        "categories": categories,
        "content": content,
      };
}
