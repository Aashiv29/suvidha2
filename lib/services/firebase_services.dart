import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to fetch caregiver contacts from Firebase
  Future<List<String>> fetchCaregiverContacts() async {
    String userId = _auth.currentUser!.uid;  // Get logged-in user ID
    List<String> caregiverNumbers = [];

    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection("users")
          .doc(userId)
          .collection("caregivers")  // Subcollection of caregivers
          .get();

      for (var doc in querySnapshot.docs) {
        caregiverNumbers.add(doc["phoneNumber"]);  // Store caregiver numbers
      }

    } catch (e) {
      print("Error fetching caregivers: $e");
    }

    return caregiverNumbers;
  }
}