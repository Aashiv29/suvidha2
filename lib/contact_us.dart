import 'package:flutter/material.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact the Team')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('We’d love to hear from you!',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                labelText: 'Your Feedback',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: Text('Submit Feedback'),
            ),
            SizedBox(height: 20),
            Text('Email: support@suvidhasaathi.com', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Phone: +91-XXXXXXXXXX', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
