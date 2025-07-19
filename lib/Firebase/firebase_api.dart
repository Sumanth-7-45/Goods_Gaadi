class UserModel111 {
  final String imageUrl;
  final String description;
  final String phone;
  final String price;
  final String vehicleBrand;
  final String vehicleModel;
  final String vehicleModelYear;
  final String numberOfOwners;
  final String vehicleFitness;
  final String insurance;
  final String accessories;
  final String loan;
  final String location;
  final String tyres;

  UserModel111({
    required this.imageUrl,
    required this.description,
    required this.phone,
    required this.price,
    required this.vehicleBrand,
    required this.vehicleModel,
    required this.vehicleModelYear,
    required this.numberOfOwners,
    required this.vehicleFitness,
    required this.insurance,
    required this.accessories,
    required this.loan,
    required this.location,
    required this.tyres,
  });

  // Convert object to Firestore-compatible Map
  Map<String, dynamic> toMap() {
    return {
      'imageUrl': imageUrl,
      'description': description,
      'phone': phone,
      'price': price,
      'vehicleBrand': vehicleBrand,
      'vehicleModel': vehicleModel,
      'vehicleModelYear': vehicleModelYear,
      'numberOfOwners': numberOfOwners,
      'vehicleFitness': vehicleFitness,
      'insurance': insurance,
      'accessories': accessories,
      'loan': loan,
      'location': location,
      'tyres': tyres,
    };
  }

  // Convert Firestore document to Dart object
  factory UserModel111.fromMap(Map<String, dynamic> map) {
    return UserModel111(
      imageUrl: map['imageUrl'] ?? '',
      description: map['description'] ?? '',
      phone: map['phone'] ?? '',
      price: map['price'] ?? '',
      vehicleBrand: map['vehicleBrand'] ?? '',
      vehicleModel: map['vehicleModel'] ?? '',
      vehicleModelYear: map['vehicleModelYear'] ?? '',
      numberOfOwners: map['numberOfOwners'] ?? '',
      vehicleFitness: map['vehicleFitness'] ?? '',
      insurance: map['insurance'] ?? '',
      accessories: map['accessories'] ?? '',
      loan: map['loan'] ?? '',
      location: map['location'] ?? '',
      tyres: map['tyres'] ?? '',
    );
  }
}
