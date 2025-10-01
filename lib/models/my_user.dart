import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  final String? id;
  final String name;
  final String email, password;

  MyUser({ this.id, required this.name, required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'name':name,
      'email':email,
      'password':password,
    };
  }

  static MyUser fromSnapshot(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return MyUser(
      id: snapshot.id,
      name: snap['name'], 
      email: snap['email'], 
      password: snap['password']
    );
  }
  
}

List<MyUser> myUsers = [
] ;