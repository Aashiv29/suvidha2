import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:convert';

class TaskManager extends StatefulWidget {
  const TaskManager({super.key});

  @override
  TaskManagerState createState() => TaskManagerState();
}

class TaskManagerState extends State<TaskManager> {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  List<Map<String, dynamic>> _tasks = [];

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _loadSavedTasks();
  }

  void _initializeNotifications() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings settings =
    InitializationSettings(android: androidSettings);

    await flutterLocalNotificationsPlugin.initialize(settings);
  }

  void _loadSavedTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedTasks = prefs.getString('tasks');

    if (savedTasks != null && savedTasks.isNotEmpty) {
      List<dynamic> decodedList = json.decode(savedTasks);
      List<Map<String, dynamic>> loadedTasks =
      decodedList.map((item) => Map<String, dynamic>.from(item)).toList();

      if (mounted) {
        setState(() {
          _tasks = loadedTasks;
        });
      }
    }
  }

  void _saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String encodedData = json.encode(_tasks);
    await prefs.setString('tasks', encodedData);
  }

  void _addTask() {
    String taskName = '';
    TimeOfDay selectedTime = TimeOfDay.now();
    List<bool> selectedDays = List.generate(7, (index) => false); // Monday-Sunday

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Add Task"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(labelText: "Task Name"),
                    onChanged: (value) => taskName = value.trim(),
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
                  const Text("Repeat on:"),
                  Wrap(
                    children: List.generate(7, (index) {
                      return ChoiceChip(
                        label: Text(
                          ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][index],
                        ),
                        selected: selectedDays[index],
                        onSelected: (bool selected) {
                          setState(() {
                            selectedDays[index] = selected;
                          });
                        },
                      );
                    }),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () => Navigator.pop(context),
                ),
                ElevatedButton(
                  child: const Text("Save"),
                  onPressed: () {
                    if (taskName.isNotEmpty && selectedDays.contains(true)) {
                      setState(() {
                        _tasks.add({
                          'name': taskName,
                          'time': {'hour': selectedTime.hour, 'minute': selectedTime.minute},
                          'days': selectedDays,
                        });
                      });

                      _scheduleNotification(taskName, selectedTime, selectedDays);
                      _saveTasks();
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please enter a task name and select at least one day."),
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

  void _scheduleNotification(String taskName, TimeOfDay time, List<bool> days) async {
    for (int i = 0; i < 7; i++) {
      if (days[i]) {
        int notificationId = DateTime.now().millisecondsSinceEpoch % 100000 + i;

        var androidDetails = const AndroidNotificationDetails(
          'task_channel',
          'Task Reminder',
          channelDescription: 'Reminder to complete your task',
          importance: Importance.high,
          priority: Priority.high,
        );

        var notificationDetails = NotificationDetails(android: androidDetails);

        DateTime now = DateTime.now();
        int todayWeekday = now.weekday - 1; // Convert Flutter weekdays (1=Monday) to 0-based index
        int daysUntilNext = (i - todayWeekday + 7) % 7; // Find next selected day
        DateTime scheduledDate = now.add(Duration(days: daysUntilNext)).copyWith(
          hour: time.hour,
          minute: time.minute,
          second: 0,
        );

        tz.TZDateTime tzScheduledDate = tz.TZDateTime.from(scheduledDate, tz.local);

        await flutterLocalNotificationsPlugin.zonedSchedule(
          notificationId,
          'Task Reminder',
          'Time to complete: $taskName',
          tzScheduledDate,
          notificationDetails,
          androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
          matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
          uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        );
      }
    }
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
      _saveTasks();
    });

    flutterLocalNotificationsPlugin.cancel(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task Manager")),
      body: _tasks.isEmpty
          ? const Center(child: Text("No tasks set! Tap + to add."))
          : ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          List<String> selectedDays = [];
          for (int i = 0; i < 7; i++) {
            if (task['days'][i]) {
              selectedDays.add(['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][i]);
            }
          }
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text(
                "${task['name']} - ${TimeOfDay(hour: task['time']['hour'], minute: task['time']['minute']).format(context)}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("Repeats on: ${selectedDays.join(', ')}"),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _deleteTask(index),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}
