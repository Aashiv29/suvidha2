// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:convert';

class MedicineReminder extends StatefulWidget {
  const MedicineReminder({super.key});

  @override
  MedicineReminderState createState() => MedicineReminderState();
}

class MedicineReminderState extends State<MedicineReminder> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  List<Map<String, dynamic>> _medicines = [];

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _loadSavedReminders();
  }

  void _initializeNotifications() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings settings =
        InitializationSettings(android: androidSettings);

    await flutterLocalNotificationsPlugin.initialize(settings);
  }

  void _loadSavedReminders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedReminders = prefs.getString('medicines');

    if (savedReminders != null && savedReminders.isNotEmpty) {
      List<dynamic> decodedList = json.decode(savedReminders);
      List<Map<String, dynamic>> loadedReminders =
          decodedList.map((item) => Map<String, dynamic>.from(item)).toList();

      if (mounted) {
        setState(() {
          _medicines = loadedReminders;
        });
      }

      // Reschedule notifications
      for (var medicine in loadedReminders) {
        _scheduleNotification(
          medicine['name'],
          TimeOfDay(hour: medicine['time']['hour'], minute: medicine['time']['minute']),
          List<int>.from(medicine['days']),
        );
      }
    }
  }

  void _saveReminders() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedData = json.encode(_medicines);
    await prefs.setString('medicines', encodedData);
  }

  void _addMedicineReminder() {
    String medicineName = '';
    TimeOfDay selectedTime = TimeOfDay.now();
    List<int> selectedDays = [];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Add Medicine Reminder"),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: "Medicine Name"),
                      onChanged: (value) => medicineName = value.trim(),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: selectedTime,
                        );
                        if (pickedTime != null) {
                          setState(() {
                            selectedTime = pickedTime;
                          });
                        }
                      },
                      child: Text("Select Time: ${selectedTime.format(context)}"),
                    ),
                    const SizedBox(height: 10),
                    const Text("Select Days"),
                    Wrap(
                      spacing: 8,
                      children: List.generate(7, (index) {
                        return FilterChip(
                          label: Text(["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"][index]),
                          selected: selectedDays.contains(index),
                          onSelected: (bool value) {
                            setState(() {
                              if (value) {
                                selectedDays.add(index);
                              } else {
                                selectedDays.remove(index);
                              }
                            });
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () => Navigator.pop(context),
                ),
                ElevatedButton(
                  child: const Text("Save"),
                  onPressed: () {
                    if (medicineName.isNotEmpty && selectedDays.isNotEmpty) {
                      setState(() {
                        _medicines.add({
                          'name': medicineName,
                          'time': {'hour': selectedTime.hour, 'minute': selectedTime.minute},
                          'days': selectedDays,
                        });
                      });

                      _scheduleNotification(medicineName, selectedTime, selectedDays);
                      _saveReminders();
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter medicine name and select at least one day."),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _scheduleNotification(String medicineName, TimeOfDay time, List<int> days) async {
    for (int day in days) {
      int notificationId = DateTime.now().millisecondsSinceEpoch % 100000;

      var androidDetails = const AndroidNotificationDetails(
        'medicine_channel',
        'Medicine Reminder',
        channelDescription: 'Reminder to take medicine',
        importance: Importance.high,
        priority: Priority.high,
      );

      var notificationDetails = NotificationDetails(android: androidDetails);

      DateTime now = DateTime.now();
      int daysUntilNextReminder = (day - now.weekday + 7) % 7;

      DateTime scheduledDate = now.add(Duration(days: daysUntilNextReminder)).copyWith(
        hour: time.hour,
        minute: time.minute,
        second: 0,
      );

      tz.TZDateTime tzScheduledDate = tz.TZDateTime.from(scheduledDate, tz.local);

      await flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId,
        'Medicine Reminder',
        'Time to take $medicineName',
        tzScheduledDate,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  void _deleteReminder(int index) {
    setState(() {
      _medicines.removeAt(index);
      _saveReminders();
    });

    flutterLocalNotificationsPlugin.cancel(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Medicine Reminders")),
      body: _medicines.isEmpty
          ? const Center(child: Text("No reminders set! Tap + to add."))
          : ListView.builder(
              itemCount: _medicines.length,
              itemBuilder: (context, index) {
                final medicine = _medicines[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      "${medicine['name']} - ${TimeOfDay(hour: medicine['time']['hour'], minute: medicine['time']['minute']).format(context)}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text("Days: ${_getDaysText(medicine['days'])}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteReminder(index),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMedicineReminder,
        child: const Icon(Icons.add),
      ),
    );
  }

  String _getDaysText(List<dynamic> days) {
    List<String> weekDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
    return days.map((index) => weekDays[index]).join(", ");
  }
}