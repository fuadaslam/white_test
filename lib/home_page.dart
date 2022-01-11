import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whiterabit_test/service/http_service.dart';
import 'package:whiterabit_test/user_details_page.dart';

import 'components/user_title.dart';
import 'models/user_model.dart';
import 'provider/Users.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Users users = Provider.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Users'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 40,
                width: MediaQuery.of(context).size.width * 0.60,
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 5.0),
                  ],
                ),
                child: CupertinoTextField(
                  keyboardType: TextInputType.text,
                  placeholder: 'Search',
                  placeholderStyle: TextStyle(
                    color: Color(0xffC4C6CC),
                    fontSize: 14.0,
                    fontFamily: 'Brutal',
                  ),
                  prefix: Padding(
                    padding: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
                    child: Icon(
                      Icons.search,
                      size: 18,
                      color: Colors.black,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: _buildBody(context),
      ),
    );
  }

  // build list view & manage states
  FutureBuilder<List<User>> _buildBody(BuildContext context) {
    final HttpService httpService = HttpService();
    return FutureBuilder<List<User>>(
      future: httpService.getPosts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<User> posts = snapshot.data;
          return Container(
            child: ListView.builder(
              itemCount: posts.length,
              padding: EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final avatar =
                posts[index].avatarUrl == null || posts[index].avatarUrl.isEmpty
                    ? CircleAvatar(child: Icon(Icons.person))
                    : CircleAvatar(
                    backgroundImage: NetworkImage(posts[index].avatarUrl));
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserDetailScreenPage(posts[index])),);
                  },
                  child: Card(
                    elevation: 4,
                    child: ListTile(
                      leading: avatar,
                      title: Text(
                        posts[index].name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(posts[index].email.toString()),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
