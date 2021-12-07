import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

User user = _auth.currentUser;
DocumentReference ref = _firestore.collection('users').doc(user.uid);

class CommentProvider {
  final CollectionReference descriptionsCollection =
      FirebaseFirestore.instance.collection('descriptions');
  Future updateDescriptionsData(String class_result, String score_result,
      String description_text, String image_url, String image_id) async {
    return await descriptionsCollection.doc().set({
      "class_result": class_result,
      "score_result": score_result,
      "Description": description_text,
      "image_url": image_url,
      "image_id": image_id,
      "uid": ref
    });
  }
}
