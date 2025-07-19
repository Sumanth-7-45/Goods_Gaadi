import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';


class FirestoreService {
  static Future<void> uploadImageData({
    required List<String> imageUrls,
    required String price,
    required String phone,
    required String description,
    required String vehicleBrand,
    required String vehicleModel,
    required String vehicleModelYear,
    required String numberOfOwners,
    required String vehiclefiteness,
    required String insurance,
    required String condition,
    required String accsessories,
    required String location,
    required String loan,
    required String tyres,


  }) async {
    final _ = FirebaseAuth.instance.currentUser;

    await FirebaseFirestore.instance.collection('users').add({
      'ImageUrl': imageUrls,
      'Price': price,
      'Phone': phone,
      'Description': description,
      'VehicleBrand': vehicleBrand,
      'vehicleModel': vehicleModel,
      'VehicleModelYear': vehicleModelYear,
      'NumberOfOwners': numberOfOwners,
      'VehicleFitness': vehiclefiteness,
      'Insurance': insurance,
      'Condition': condition,
      'Accessories': accsessories,
      'Location': location,
      'Loan': loan,
      'Tyres Condition': tyres,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}

