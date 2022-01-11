import 'dart:convert';
import 'package:http/http.dart';
import 'package:whiterabit_test/models/user_model.dart';

class HttpService {
  final String postsURL = "http://www.mocky.io/v2/5d565297300000680030a986";

  Future<List<User>> getPosts() async {
    Response res = await get(Uri.parse(postsURL));

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<User> posts = body
          .map(
            (dynamic item) => User.fromJson(item),
      )
          .toList();

      return posts;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}