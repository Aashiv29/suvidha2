import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CaregiverScreen extends StatefulWidget {
  @override
  _CaregiverScreenState createState() => _CaregiverScreenState();
}

class _CaregiverScreenState extends State<CaregiverScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _relationshipController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isSaving = false;
  String _status = "";

  Future<void> _saveCaregiver() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isSaving = true;
      _status = "Saving...";
    });

    try {
      final user = _auth.currentUser;
      if (user == null) {
        setState(() {
          _status = "User not signed in";
        });
        return;
      }

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('caregivers')
          .add({
        'name': _nameController.text.trim(),
        'phone': _phoneController.text.trim(),
        'email': _emailController.text.trim(),
        'relationship': _relationshipController.text.trim(),
        'timestamp': FieldValue.serverTimestamp(),
      });

      setState(() {
        _status = "Caregiver added!";
        _formKey.currentState!.reset();
      });
    } catch (e) {
      setState(() {
        _status = "Error: ${e.toString()}";
      });
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  Stream<QuerySnapshot> _getCaregiversStream() {
    final user = _auth.currentUser;
    if (user == null) return const Stream.empty();

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('caregivers')
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Caregivers')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Add a New Caregiver", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: "Name"),
                    validator: (val) => val == null || val.isEmpty ? "Required" : null,
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(labelText: "Phone"),
                    validator: (val) => val == null || val.isEmpty ? "Required" : null,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: "Email (optional)"),
                  ),
                  TextFormField(
                    controller: _relationshipController,
                    decoration: InputDecoration(labelText: "Relationship"),
                    validator: (val) => val == null || val.isEmpty ? "Required" : null,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _isSaving ? null : _saveCaregiver,
                    child: Text("Add Caregiver"),
                  ),
                  if (_status.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        _status,
                        style: TextStyle(
                          color: _status.contains("Error") ? Colors.red : Colors.green,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Divider(height: 40),
            Text("Your Caregivers", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            StreamBuilder<QuerySnapshot>(
              stream: _getCaregiversStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return CircularProgressIndicator();

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty)
                  return Text("No caregivers added yet.");

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final doc = snapshot.data!.docs[index];
                    final data = doc.data() as Map<String, dynamic>;

                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      child: ListTile(
                        title: Text(data['name'] ?? ''),
                        subtitle: Text("${data['relationship'] ?? ''} • ${data['phone'] ?? ''}"),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            await doc.reference.delete();
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            Divider(height: 30),
            ElevatedButton.icon(
              icon: Icon(Icons.sos),
              label: Text("Test SOS (to caregivers)"),
              onPressed: () {
                // You can add actual SMS/email code here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("SOS would be sent here")),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}