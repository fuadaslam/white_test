import 'dart:math';

import 'package:flutter/material.dart';
import 'package:whiterabit_test/data/dummy_users.dart';
import 'package:whiterabit_test/models/user_model.dart';
class Users with ChangeNotifier{
  final Map<String, User> _items  = {};

  List<User> get all {
    return [..._items.values];
  }

  int get count {
    return _items.length;
  }

  User byIndex(int i){
    return _items.values.elementAt(i);
  }

  void put(User user){
    if(user == null){
      return;
    }

    if(user.id != null && user.id.trim().isNotEmpty &&  _items.containsKey(user.id)){
      _items.update(user.id, (_) => User(
        id: user.id,
        name: user.name,
        email: user.email,
        avatarUrl: user.avatarUrl,  
      ));
    } else {
      final id = Random().nextDouble().toString();

      _items.putIfAbsent(id, () => User(
        id: id,
        name: user.name,
        email: user.email,
        avatarUrl: user.avatarUrl,
      ));

    }
    notifyListeners();


  }
  
  void remove(User user){
    //print(user.id);
    if(user != null && user.id != null) {
      _items.remove(user.id);
    }
    notifyListeners();

  }

}