import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:self/Cloud/cloudinary.dart';
import 'package:self/Firebase/firebase_Img_data.dart';
import 'Firebase/firebase_api.dart';
import 'ImageUpload/image.dart';

class MultiImageUploadScreen1 extends StatefulWidget {
  const MultiImageUploadScreen1({Key? key}) : super(key: key);

  @override
  MultiImageUploadScreen1State createState() => MultiImageUploadScreen1State();
}

class MultiImageUploadScreen1State extends State<MultiImageUploadScreen1> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedImages = [];

  final TextEditingController priceController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController vehicleBrandController = TextEditingController();
  final TextEditingController vehicleModelController = TextEditingController();
  final TextEditingController vehicleModelYearController = TextEditingController();
  final TextEditingController numberOfOwnersController = TextEditingController();
  final TextEditingController vehiclefitenessController = TextEditingController();
  final TextEditingController insuranceController = TextEditingController();
  final TextEditingController conditionController = TextEditingController();
  final TextEditingController accsessoriesController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController loanController = TextEditingController();
  final TextEditingController tyresConstroller = TextEditingController();

  bool _isUploading = false;

  Future<void> pickImages() async {
    final picked = await _picker.pickMultiImage();
    if (picked.isNotEmpty) {
      setState(() => _selectedImages = picked);
    }
  }

  Future<void> uploadAll() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User not signed in")));
      }
      return;
    }

    if (_selectedImages.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("All fields are required")));
      }
      return;
    }

    setState(() => _isUploading = true);

    final price = priceController.text.trim();
    final phone = phoneController.text.trim();
    final description = descriptionController.text.trim();
    final vehicleBrand = vehicleBrandController.text.trim();
    final vehicleModel = vehicleModelController.text.trim();
    final vehicleModelYear = vehicleModelYearController.text.trim();
    final numberOfOwners = numberOfOwnersController.text.trim();
    final vehicleFitness = vehiclefitenessController.text.trim();
    final insurance = insuranceController.text.trim();
    final accessories = accsessoriesController.text.trim();
    final loan = loanController.text.trim();
    final location = locationController.text.trim();
    final tyres = tyresConstroller.text.trim();

    List<UserModel111> uploadedPosts = [];

    for (XFile image in _selectedImages) {
      final String? imageUrl = await CloudinaryService1.uploadImage1(File(image.path));
      if (imageUrl != null) {
        uploadedPosts.add(UserModel111(
          imageUrl: imageUrl,
          description: description,
          phone: phone,
          price: price,
          vehicleBrand: vehicleBrand,
          vehicleModel: vehicleModel,
          vehicleModelYear: vehicleModelYear,
          numberOfOwners: numberOfOwners,
          vehicleFitness: vehicleFitness,
          insurance: insurance,
          accessories: accessories,
          loan: loan,
          location: location,
          tyres: tyres,
        ));
      }
    }

    if (uploadedPosts.isNotEmpty) {
      await FirestoreService1().savePostsForUser(
        userId: user.uid,
        posts: uploadedPosts,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Upload successful")));
      }

      setState(() {
        priceController.clear();
        phoneController.clear();
        descriptionController.clear();
        vehicleBrandController.clear();
        vehicleModelController.clear();
        vehicleModelYearController.clear();
        numberOfOwnersController.clear();
        vehiclefitenessController.clear();
        insuranceController.clear();
        accsessoriesController.clear();
        loanController.clear();
        locationController.clear();
        tyresConstroller.clear();
        _selectedImages.clear();
        _isUploading = false;
      });
    } else {
      setState(() => _isUploading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Image upload failed")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Your Vehicle Details",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),backgroundColor: Colors.blueAccent,centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
              onPressed: pickImages,
              icon: const Icon(Icons.image,color: Colors.white),
              label: const Text("Select Images",style: TextStyle(color: Colors.white),),
            ),
            const SizedBox(height: 10),
            ImagePickerPreview(images: _selectedImages),
            const SizedBox(height: 20),
            TextField( controller: priceController, decoration: InputDecoration(labelText: 'Price',border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),),focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12))), keyboardType: TextInputType.number),const SizedBox(height: 20),
            TextField(controller: vehicleBrandController, decoration: InputDecoration(labelText: 'Vehicle Brand',contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),),focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12))), keyboardType: TextInputType.text),const SizedBox(height: 20),
            TextField(controller: vehicleModelController, decoration: InputDecoration(labelText: 'vehicleModel',border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),),focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12))), keyboardType: TextInputType.text),const SizedBox(height: 20),
            TextField(controller: vehicleModelYearController, decoration: InputDecoration(labelText: 'Model Year',border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),),focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12))), keyboardType: TextInputType.text),const SizedBox(height: 20),
            TextField( controller: vehiclefitenessController, decoration: InputDecoration(labelText: 'Vehicle fiteness',border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),),focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12))), keyboardType: TextInputType.number),const SizedBox(height: 20),
            TextField(controller: numberOfOwnersController, decoration: InputDecoration(labelText: 'Number Of Owners',border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),),focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12))), keyboardType: TextInputType.text),const SizedBox(height: 20),
            TextField(controller: insuranceController, decoration: InputDecoration(labelText: 'Insurance',border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),),focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12))), keyboardType: TextInputType.text),const SizedBox(height: 20),
            TextField(controller: tyresConstroller, decoration: InputDecoration(labelText: 'Tyres Condition',border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),),focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12))), keyboardType: TextInputType.text),const SizedBox(height: 20),
            TextField(controller: accsessoriesController, decoration: InputDecoration(labelText: 'Accessories',border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),),focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12))), keyboardType: TextInputType.text),const SizedBox(height: 20),
            TextField(controller: loanController, decoration: InputDecoration(labelText: 'Loan Limit',border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),),focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12))), keyboardType: TextInputType.text),const SizedBox(height: 20),
            TextField(controller: descriptionController, decoration: InputDecoration(labelText: 'Description',border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),),focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12))), keyboardType: TextInputType.text),const SizedBox(height: 20),
            TextField(controller: phoneController, decoration: InputDecoration(labelText: 'Phone Number',border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),),focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12))), keyboardType: TextInputType.text),const SizedBox(height: 20),
            TextField(controller: locationController, decoration: InputDecoration(labelText: 'Location',border: OutlineInputBorder(borderRadius: BorderRadius.circular(12),),focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12))), keyboardType: TextInputType.text),const SizedBox(height: 20),
            const SizedBox(height: 20),
            _isUploading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue,foregroundColor: Colors.white,padding: const EdgeInsets.symmetric(vertical: 16)),
              onPressed: uploadAll,
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
