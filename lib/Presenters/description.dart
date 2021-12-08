import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
User user = _auth.currentUser;
DocumentReference ref = _firestore.collection('users').doc(user.uid);
DocumentReference ref2 = _firestore.collection('descriptions').doc();

class CommentProvider {
  final CollectionReference descriptionsCollection =
      FirebaseFirestore.instance.collection('descriptions');
  Future updateDescriptionsData(
      String classResult,
      String scoreResult,
      String descriptionText,
      String imageUrl,
      String imageId,
      String dateTime) async {
    return await descriptionsCollection.doc().set({
      "class_result": classResult,
      "score_result": scoreResult,
      "description": descriptionText,
      "image_url": imageUrl,
      "image_id": imageId,
      "uid": ref,
      "data-time": dateTime,
      "doc-id": ref2.id,
    });
  }
}
