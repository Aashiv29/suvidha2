import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';

class CaregiverDetailsPage extends StatefulWidget {
  final String userId;

  const CaregiverDetailsPage({super.key, required this.userId});

  @override
  CaregiverDetailsPageState createState() => CaregiverDetailsPageState();
}

class CaregiverDetailsPageState extends State<CaregiverDetailsPage> {
  List<Map<String, dynamic>> caregivers = [];
  int? selectedPrimaryIndex;

  void addCaregiver() {
    if (caregivers.length < 3) {
      setState(() {
        caregivers.add({
          'name': '',
          'relationship': '',
          'phone': '',
          'isPrimary': false,
        });
      });
    }
  }

  Future<void> saveCaregivers() async {
    if (caregivers.isEmpty ||
        caregivers.any((c) =>
            c['name']!.isEmpty || c['relationship']!.isEmpty || c['phone']!.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all caregiver details'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (selectedPrimaryIndex == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select a primary contact'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    caregivers = caregivers.asMap().entries.map((entry) {
      int index = entry.key;
      var caregiver = entry.value;
      return {
        ...caregiver,
        'isPrimary': index == selectedPrimaryIndex,
      };
    }).toList();

    try {
      await FirebaseFirestore.instance.collection('users').doc(widget.userId).update({
        'caregivers': caregivers,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Caregiver details saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      if (!context.mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } catch (e) {
      print("Error saving caregivers: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save caregiver details'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Contacts'),
        backgroundColor: Color(0xFF2E7D32),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Add up to 3 emergency contacts',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: caregivers.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Radio<int>(
                                value: index,
                                groupValue: selectedPrimaryIndex,
                                onChanged: (int? value) {
                                  setState(() {
                                    selectedPrimaryIndex = value;
                                  });
                                },
                              ),
                              Text(
                                'Set as Primary',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              if (selectedPrimaryIndex == index)
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Icon(Icons.star, color: Colors.amber),
                                ),
                            ],
                          ),
                          TextField(
                            decoration: InputDecoration(labelText: 'Name'),
                            onChanged: (value) => caregivers[index]['name'] = value,
                          ),
                          TextField(
                            decoration: InputDecoration(labelText: 'Relationship'),
                            onChanged: (value) => caregivers[index]['relationship'] = value,
                          ),
                          TextField(
                            decoration: InputDecoration(labelText: 'Phone Number'),
                            keyboardType: TextInputType.phone,
                            onChanged: (value) => caregivers[index]['phone'] = value,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: caregivers.length < 3 ? addCaregiver : null,
              child: Text('Add Another Contact'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveCaregivers,
              child: Text('Save and Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
