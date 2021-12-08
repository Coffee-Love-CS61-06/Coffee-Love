import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_love/Models/description.dart';

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

  // brew list from snapshot
  List<Descriptions> _historyListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final eventData = doc.data();
      //print(doc.data);
      return Descriptions(
        class_result: (doc.data() as dynamic)['class_result'],
        score_result: (doc.data() as dynamic)['score_result'],
      );
    }).toList();
  }

  // get description stream
  Stream<List<Descriptions>> get descriptions {
    return descriptionCollection
        .where('uid', isEqualTo: uid)
        .snapshots()
        .map(_historyListFromSnapshot);
  }
}
