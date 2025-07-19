import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_api.dart';

class FirestoreService1 {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> savePostsForUser({
    required String userId,
    required List<UserModel111> posts,
  }) async {
    final uploadsRef = _firestore.collection('users').doc(userId).collection('uploads');
    final uploadId = DateTime.now().millisecondsSinceEpoch.toString(); // like folder name
    final uploadFolder = uploadsRef.doc(uploadId);

    for (UserModel111 post in posts) {
      final postId = _firestore.collection('temp').doc().id; // random document ID
      await uploadFolder.collection('images').doc(postId).set(post.toMap());
    }

    // optional: save metadata
    await uploadFolder.set({
      'createdAt': FieldValue.serverTimestamp(),
      'totalImages': posts.length,
    });
  }
}
