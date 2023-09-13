import 'package:flutter/material.dart';

class Teste extends StatefulWidget {
  @override
  _TesteState createState() => _TesteState();
}

class _TesteState extends State<Teste> {
  bool _monday = false;
  bool _tuesday = false;
  bool _wednesday = false;
  bool _thursday = false;
  bool _friday = false;
  bool _saturday = false;
  bool _sunday = false;
  bool _notification = false;
  String _taskTitle = '';
  TimeOfDay _selectedTime = TimeOfDay.now();

  void _toggleDay(bool value, String day) {
    setState(() {
      switch (day) {
        case 'Monday':
          _monday = value;
          break;
        case 'Tuesday':
          _tuesday = value;
          break;
        case 'Wednesday':
          _wednesday = value;
          break;
        case 'Thursday':
          _thursday = value;
          break;
        case 'Friday':
          _friday = value;
          break;
        case 'Saturday':
          _saturday = value;
          break;
        case 'Sunday':
          _sunday = value;
          break;
      }
    });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _addTask() {
    // Implement your logic to add the task
    print('Task added: $_taskTitle');
    print('Selected time: $_selectedTime');
    print('Days: Monday: $_monday, Tuesday: $_tuesday, Wednesday: $_wednesday, '
        'Thursday: $_thursday, Friday: $_friday, Saturday: $_saturday, Sunday: $_sunday');
    print('Notification: $_notification');
  }

  void _openModal(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.7,
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Modal Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _openModal(context);
          },
          child: Text('Open Modal'),
        ),
      ),
    );
  }
}
