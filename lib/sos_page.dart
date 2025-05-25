import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';


class SOSButton extends StatefulWidget {
  const SOSButton({super.key});

  @override
  SOSButtonState createState() => SOSButtonState();
}

class SOSButtonState extends State<SOSButton> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Telephony telephony = Telephony.instance;
  
  List<String> emergencyContacts = [];
  String primaryContact = "";
  bool _isLoadingLocation = false;

  @override
  void initState() {
    super.initState();
    _loadUserSettings();
  }

  Future<void> _loadUserSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await _fetchEmergencyContacts();
  }

  Future<void> _fetchEmergencyContacts() async {
    String userId = _auth.currentUser?.uid ?? "";
    if (userId.isEmpty) return;

    try {
      DocumentSnapshot userDoc = await _firestore.collection("users").doc(userId).get();
      if (userDoc.exists && userDoc.data() != null) {
        if (userDoc["caregivers"] != null) {
          List<dynamic> caregivers = userDoc["caregivers"];
          setState(() {
            emergencyContacts = caregivers.map((c) => c['phone'].toString()).toList();
            primaryContact = emergencyContacts.isNotEmpty ? emergencyContacts.first : "";
          });
        }
      }
    } catch (e) {
      print("Error fetching emergency contacts: $e");
    }
  }

  Future<bool> _requestPermissions() async {
    var callStatus = await Permission.phone.request();
    var smsStatus = await Permission.sms.request();
    var locationStatus = await Permission.location.request();
    return callStatus.isGranted && smsStatus.isGranted && locationStatus.isGranted;
  }

  Future<void> _makeSOSCall() async {
  if (primaryContact.isEmpty) {
    print("No primary contact available.");
    return;
  }

  bool permissionsGranted = await _requestPermissions();
  if (!permissionsGranted) {
    print("Permissions not granted for call.");
    return;
  }

  try {
    await FlutterPhoneDirectCaller.callNumber(primaryContact);
    print("Calling $primaryContact...");
  } catch (e) {
    print("Error making direct call: $e");
  }
}

  Future<String> _getUserLocation() async {
    setState(() => _isLoadingLocation = true);
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return "https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}";
    } catch (e) {
      return "Unable to retrieve location.";
    } finally {
      setState(() => _isLoadingLocation = false);
    }
  }

  Future<void> _sendSOSMessage() async {
  if (emergencyContacts.isEmpty) {
    print("No emergency contacts available.");
    return;
  }

  bool smsPermissionsGranted = await telephony.requestSmsPermissions ?? false;
  if (!smsPermissionsGranted) {
    print("Telephony SMS permission not granted.");
    return;
  }

  String location = await _getUserLocation();
  String message = "🚨 SOS Alert! I need help. My location: $location";

  try {
    for (String contact in emergencyContacts) {
      await telephony.sendSms(
        to: contact,
        message: message,
        isMultipart: true, // in case message is long
      );
    }
    print("SOS SMS sent successfully.");
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("SOS alert sent via SMS.")),
      );
    }
  } catch (e) {
    print("Failed to send SOS SMS: $e");
  }
}


  void _triggerSOS() async {
    await _makeSOSCall();  // Calls primary caregiver
    await _sendSOSMessage();  // Sends location SMS to all contacts
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _isLoadingLocation ? null : _triggerSOS,
      child: _isLoadingLocation
          ? CircularProgressIndicator(color: Colors.white)
          : Icon(Icons.sos, color: Colors.white),
      backgroundColor: Colors.red,
    );
  }
}