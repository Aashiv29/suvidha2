import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences
// import 'login.dart';
import 'caregiver_details_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  RegistrationPageState createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _isLoading = false;

  Future<void> register(BuildContext context) async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('All fields are required'), backgroundColor: Colors.red),
      );
      setState(() => _isLoading = false);
      return;
    }

    try {
      print("Attempting Firebase Registration");
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      User? user = userCredential.user;
      if (user == null) {
        throw Exception("User registration failed");
      }

      print("User registered: ${user.uid}");

      try {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'phone': _phoneController.text.trim(),
          'createdAt': FieldValue.serverTimestamp(),
          'caregivers':[],
        });

        print("User data stored in Firestore");
      } catch (e, stackTrace) {
        print("Firestore Error: $e");
        print("StackTrace: $stackTrace"); // Print stack trace for Firestore error
        throw Exception("Failed to save user data");
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration successful!'), backgroundColor: Colors.green),
      );

      // Set isLoggedIn to true in shared_preferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      if (!context.mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CaregiverDetailsPage(userId: user.uid)),
      );
    } on FirebaseAuthException catch (e, stackTrace) {
      print("FirebaseAuthException: ${e.message}");
      print("StackTrace: $stackTrace"); // Print stack trace for FirebaseAuthException
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Registration failed'), backgroundColor: Colors.red),
      );
    } catch (e, stackTrace) {
      print("Error: $e");
      print("StackTrace: $stackTrace"); // Print stack trace for general exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred'), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAF3E0),
      appBar: AppBar(
        title: Text('Register', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF2E7D32),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 6,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text('Create an Account',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2E7D32))),
                  SizedBox(height: 20),
                  _buildTextField(_nameController, 'Name', Icons.person),
                  _buildTextField(_emailController, 'Email', Icons.email),
                  _buildTextField(_phoneController, 'Phone Number', Icons.phone),
                  _buildTextField(_passwordController, 'Password', Icons.lock, obscureText: true),
                  SizedBox(height: 20),
                  _buildRegisterButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool obscureText = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Color(0xFF2E7D32)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Color(0xFFF0F4C3),
        ),
      ),
    );
  }

  Widget _buildRegisterButton(BuildContext context) {
    return ElevatedButton(
      onPressed: _isLoading ? null : () => register(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: _isLoading ? Colors.grey : Color(0xFF2E7D32),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
      ),
      child: _isLoading
          ? CircularProgressIndicator(color: Colors.white)
          : Text('Register', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}