import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DisplayScreen extends StatefulWidget {
  final String uploadId;
  const DisplayScreen({Key? key, required this.uploadId}) : super(key: key);
  @override
  State<DisplayScreen> createState() => _DisplayScreenState();
}
class _DisplayScreenState extends State<DisplayScreen> {
  final PageController _pageController = PageController();
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text("❌ User not logged in")),
      );
    }
    final imageCollection = FirebaseFirestore.instance.collection('users').doc(user.uid).collection('uploads').doc(widget.uploadId).collection('images');
    return Scaffold(
      appBar: AppBar(title: const Text("Goods Gaadi.Com",style: TextStyle(color: Colors.white,fontFamily: 'FontMain'),),
      backgroundColor: Colors.blueAccent,
      leading: Padding(padding: EdgeInsets.all(8.0),child: Image.asset('assets1/logo.png', width: 24, height: 24,),),),
      body: FutureBuilder<QuerySnapshot>(
        future: imageCollection.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("❌ No image data found"));
          }
          final docs = snapshot.data!.docs;
          final imageUrls = docs.map((doc) => doc['imageUrl'] as String?).whereType<String>().toList();
          final firstDoc = docs.first.data() as Map<String, dynamic>;
          return SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [SizedBox(height: 300,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: imageUrls.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(imageUrls[index],
                            fit: BoxFit.cover, width: double.infinity,
                            loadingBuilder: (context, child, loading) {
                              if (loading == null) return child;
                              return const Center(child: CircularProgressIndicator());
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Center(child: SmoothPageIndicator(
                    controller: _pageController,
                    count: imageUrls.length,
                    effect: const WormEffect(
                      dotHeight: 10, dotWidth: 10, activeDotColor: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Row(
                        children: [
                          const Icon(Icons.directions_car,color: Colors.blue,),
                          const SizedBox(width: 8),
                          Text(" ${firstDoc['vehicleBrand'] ?? 'N/A'}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(children: [
                          const Icon(Icons.calendar_month,color: Colors.blue,),
                          const SizedBox(width: 8),
                          Text("Year: ${firstDoc['vehicleModelYear'] ?? 'N/A'}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(children: [
                          const Icon(Icons.shield),
                          const SizedBox(width: 8),
                          Text("Insurance: ${firstDoc['insurance'] ?? 'N/A'}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(children: [
                          const Icon(Icons.article),
                          const SizedBox(width: 8),
                          Text("Fitness Certificate: ${firstDoc['vehicleFitness'] ?? 'N/A'}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(children: [
                          const Icon(Icons.location_city),
                          const SizedBox(width: 8),
                          Text("location: ${firstDoc['location'] ?? 'N/A'}",style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const SizedBox(width: 8),
                          Text("₹ ${firstDoc['price'] ?? 'N/A'}",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(children: [
                          Material(elevation: 4, color: Colors.blueAccent, borderRadius: BorderRadius.circular(10),
                            child: MaterialButton(padding: const EdgeInsets.fromLTRB(10, 10, 20, 10), minWidth: 375,
                              onPressed: (){},
                            child: Text('Call',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(children: [
                          Material(elevation: 4, color: Colors.blueAccent, borderRadius: BorderRadius.circular(10),
                            child: MaterialButton(
                              padding: const EdgeInsets.fromLTRB(10, 10, 20, 10), minWidth: 375,
                              onPressed: (){},
                              child: Text('Email',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(children: [
                          Material(elevation: 2, color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(10), child: MaterialButton(
                              padding: const EdgeInsets.fromLTRB(10, 10, 20, 10), minWidth: 375,
                              onPressed: (){},
                              child: Text('WhastsApp',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text('Vehicle Details',style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 16),

                      Row(
                        children: [
                          const SizedBox(width: 8),
                          Text("Tyres Condition: ${firstDoc['tyres'] ?? 'N/A'}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(children: [
                          const SizedBox(width: 8),
                          Text("Accessories: ${firstDoc['accessories'] ?? 'N/A'}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(children: [
                          const SizedBox(width: 8),
                          Text("Number Of Owners: ${firstDoc['numberOfOwners'] ?? 'N/A'}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),],
                      ),
                      const SizedBox(height: 16),
                      const Text("Description:", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
                      const SizedBox(height: 4),
                      Text(firstDoc['description'] ?? 'No description provided'),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}