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
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 600.0,
          padding: EdgeInsets.all(16.0),
          child: Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add Task',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Task Title'),
                  onChanged: (value) {
                    setState(() {
                      _taskTitle = value;
                    });
                  },
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => _selectTime(context),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Time',
                            border: OutlineInputBorder(),
                          ),
                          child: Text(
                            _selectedTime.format(context),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    TextButton(
                      onPressed: () => _selectTime(context),
                      child: Text('Select Time'),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Wrap(children: [
                      for (var day in [
                        'Monday',
                        'Tuesday',
                        'Wednesday',
                        'Thursday',
                        'Friday',
                        'Saturday',
                        'Sunday'
                      ])
                        Expanded(
                          child: Row(
                            children: [
                              Checkbox(
                                value: day == 'Monday'
                                    ? _monday
                                    : day == 'Tuesday'
                                        ? _tuesday
                                        : day == 'Wednesday'
                                            ? _wednesday
                                            : day == 'Thursday'
                                                ? _thursday
                                                : day == 'Friday'
                                                    ? _friday
                                                    : day == 'Saturday'
                                                        ? _saturday
                                                        : _sunday,
                                onChanged: (value) => _toggleDay(value!, day),
                              ),
                              Text(day),
                            ],
                          ),
                        ),
                    ]),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _notification,
                      onChanged: (value) {
                        setState(() {
                          _notification = value!;
                        });
                      },
                    ),
                    Text('Enable Notification'),
                  ],
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _addTask();
                    Navigator.of(context).pop();
                  },
                  child: Text('Add Task'),
                ),
              ],
            ),
          ),
        );
      },
    );
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
