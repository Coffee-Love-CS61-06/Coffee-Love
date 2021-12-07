import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

   final String uid;


  DatabaseService({this.uid });

  // collection reference
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

  Future updateUserData(String email, String firstname, 
  String lastname) async {
     return await userCollection.doc(uid).set({
       'uid' : uid,
       'email': email,
       'firstname': firstname,
       'lastname': lastname,


     });
   }
 }


