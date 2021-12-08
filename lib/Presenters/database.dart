import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_love/Models/description.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
User user = _auth.currentUser;
DocumentReference ref = _firestore.collection('users').doc(user.uid);

class DatabaseService {
  final String uid;

  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference descriptionCollection =
      FirebaseFirestore.instance.collection('descriptions');

  Future updateUserData(String email, String firstname, String lastname) async {
    return await userCollection.doc(uid).set({
      'uid': uid,
      'email': email,
      'firstname': firstname,
      'lastname': lastname,
    });
  }

  // list from snapshot
  List<Descriptions> _historyListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return Descriptions(
          classResult: (doc.data() as dynamic)['class_result'],
          scoreResult: (doc.data() as dynamic)['score_result'],
          descriptionText: (doc.data() as dynamic)['description'],
          imageUrl: (doc.data() as dynamic)['image_url'],
          imageId: (doc.data() as dynamic)['image_id'],
          userId: (doc.data() as dynamic)['user_id'],
          dateTime: (doc.data() as dynamic)['data-time'],
          docId: (doc.data() as dynamic)['doc_id']);
    }).toList();
  }

  // get description stream
  Stream<List<Descriptions>> get descriptions {
    return descriptionCollection
        .where('uid', isEqualTo: ref)
        .snapshots()
        .map(_historyListFromSnapshot);
  }
}
