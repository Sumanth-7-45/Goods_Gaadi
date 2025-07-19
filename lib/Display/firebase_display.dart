import 'package:cloud_firestore/cloud_firestore.dart';
import '../Firebase/firebase_api.dart';
 // for UserModel111

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Saves user uploads under their account AND globally
  Future<void> savePostsForUser({
    required String userId,
    required List<UserModel111> posts,
  }) async {
    // Private path for current user
    final privateUploadsRef = _firestore.collection('users').doc(userId).collection('uploads');
    final uploadId = DateTime.now().millisecondsSinceEpoch.toString();
    final uploadFolder = privateUploadsRef.doc(uploadId);

    for (UserModel111 post in posts) {
      final postId = _firestore.collection('temp').doc().id;

      // 1. Save to user's private images folder
      await uploadFolder.collection('images').doc(postId).set(post.toMap());

      // 2. Save to global uploads collection
      await _firestore.collection('uploads').doc(postId).set({
        ...post.toMap(),
        'userId': userId,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    // Metadata (optional)
    await uploadFolder.set({
      'createdAt': FieldValue.serverTimestamp(),
      'totalImages': posts.length,
    });
  }
}
