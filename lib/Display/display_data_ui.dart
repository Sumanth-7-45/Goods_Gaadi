import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:self/Display/all_data_display.dart';

class UploadedImagesScreen extends StatelessWidget {
  const UploadedImagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Center(child: Text("User not signed in"));
    }
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('uploads')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, uploadsSnapshot) {
        if (uploadsSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!uploadsSnapshot.hasData || uploadsSnapshot.data!.docs.isEmpty) {
          return Center(child: Text("No uploads found"));
        }

        final uploads = uploadsSnapshot.data!.docs;

        return ListView.builder(
          itemCount: uploads.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(), // Use inside scroll views
          itemBuilder: (context, index) {
            final uploadDoc = uploads[index];
            final uploadId = uploadDoc.id;

            return FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('users').doc(user.uid).collection('uploads').doc(uploadId).collection('images').limit(1).get(),
              builder: (context, imageSnapshot) {
                if (imageSnapshot.connectionState == ConnectionState.waiting) {
                  return SizedBox(); // or loading
                }

                if (!imageSnapshot.hasData || imageSnapshot.data!.docs.isEmpty) {
                  return SizedBox(); // no image
                }
                final imageDoc = imageSnapshot.data!.docs.first;
                final data = imageDoc.data() as Map<String, dynamic>;
                final imageUrl = data['imageUrl'] ?? '';
                final brand = data['vehicleBrand'] ?? '';
                final price =data['price'] ??'';

                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DisplayScreen(uploadId: uploadId,)));
                  },
                  child: Card(margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: Column(children: [
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                          child: Image.network(imageUrl, height: 200, width: double.infinity, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Container(height: 200, color: Colors.grey[300], child: Icon(Icons.broken_image),
                            ),
                          ),
                        ),
                        Padding(padding: const EdgeInsets.all(12.0),
                          child: Row(children: [
                              Icon(Icons.directions_car, color: Colors.blueAccent),
                              SizedBox(width: 8),
                              Text(brand, style:  TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 80),
                                  Text('Price: ',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                  Icon(Icons.currency_rupee,color:Colors.blueAccent,),
                                  SizedBox(width: 0),
                                  Text(price, style: TextStyle(fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              const Row(
                                children: [
                                  //SizedBox(width: 80),
                                  Column(
                                    children: [
                                      Icon(Icons.verified, color: Colors.green,),SizedBox(width: 2),],),],
                              )
                            ],
                          ),
                        ),],),),
                );
              },);},);
      },);}}
