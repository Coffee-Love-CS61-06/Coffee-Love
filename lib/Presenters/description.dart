import 'package:cloud_firestore/cloud_firestore.dart';

class CommentProvider {
  final CollectionReference descriptionsCollection =
      FirebaseFirestore.instance.collection('descriptions');
  Future updateDescriptionsData(String description) async {
    return await descriptionsCollection.doc().set({
      'description': description,
    });
  }
}
