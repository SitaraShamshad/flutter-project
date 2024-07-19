import 'package:flutter/material.dart';

class Goal {
  String title;
  String description;
  DateTime startDate;
  DateTime endDate;
  int progress;

  Goal({
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    this.progress = 0,
  });
}

class GoalTrackerScreen extends StatefulWidget {
  @override
  _GoalTrackerScreenState createState() => _GoalTrackerScreenState();
}

class _GoalTrackerScreenState extends State<GoalTrackerScreen> {
  final List<Goal> goals = [];
  final _formKey = GlobalKey<FormState>();
  String newTitle = '';
  String newDescription = '';
  DateTime newStartDate = DateTime.now();
  DateTime newEndDate = DateTime.now().add(Duration(days: 7));

  int selectedGoalIndex = -1;

  void _addOrUpdateGoal() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        if (selectedGoalIndex == -1) {
          goals.add(Goal(
            title: newTitle,
            description: newDescription,
            startDate: newStartDate,
            endDate: newEndDate,
          ));
        } else {
          goals[selectedGoalIndex]
            ..title = newTitle
            ..description = newDescription
            ..startDate = newStartDate
            ..endDate = newEndDate;
          selectedGoalIndex = -1;
        }
      });
    }
  }

  void _selectGoalForUpdate(int index) {
    setState(() {
      selectedGoalIndex = index;
      newTitle = goals[index].title;
      newDescription = goals[index].description;
      newStartDate = goals[index].startDate;
      newEndDate = goals[index].endDate;
    });
  }

  void _updateProgress(int index, int progress) {
    setState(() {
      goals[index].progress = progress;
    });
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? newStartDate : newEndDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          newStartDate = picked;
        } else {
          newEndDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Goal Tracker'),
        backgroundColor: Color(0xFF008080), // Teal color for the AppBar
      ),
      body: Container(
        color: Color(0xFFE0F7FA), // Light teal background color
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: newTitle,
                      decoration: InputDecoration(
                        labelText: 'Title',
                        fillColor: Color(0xFFB2EBF2), // Light teal color for text field background
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onSaved: (value) {
                        newTitle = value ?? '';
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      initialValue: newDescription,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        fillColor: Color(0xFFB2EBF2), // Light teal color for text field background
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onSaved: (value) {
                        newDescription = value ?? '';
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a description';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Start Date: ${newStartDate.toLocal()}'.split(' ')[0]),
                        ElevatedButton(
                          onPressed: () => _selectDate(context, true),
                          child: Text('Select Start Date', style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF008080), // Teal color for buttons
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('End Date: ${newEndDate.toLocal()}'.split(' ')[0]),
                        ElevatedButton(
                          onPressed: () => _selectDate(context, false),
                          child: Text('Select End Date', style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF008080), // Teal color for buttons
                            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _addOrUpdateGoal,
                      child: Text(selectedGoalIndex == -1 ? 'Add Goal' : 'Update Goal', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF008080), // Teal color for buttons
                        padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: goals.length,
                itemBuilder: (context, index) {
                  final goal = goals[index];
                  return Card(
                    color: Color(0xFFB2EBF2), // Light teal color for goal cards
                    child: ListTile(
                      title: Text(goal.title),
                      subtitle: Text(goal.description),
                      trailing: CircularProgressIndicator(
                        value: goal.progress / 100,
                        backgroundColor: Colors.grey,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                      onTap: () => _selectGoalForUpdate(index),
                      onLongPress: () => _showProgressDialog(context, index),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showProgressDialog(BuildContext context, int index) {
    int newProgress = goals[index].progress;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Progress'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Current Progress: ${goals[index].progress}%'),
              Slider(
                value: newProgress.toDouble(),
                min: 0,
                max: 100,
                divisions: 100,
                label: '$newProgress%',
                onChanged: (value) {
                  setState(() {
                    newProgress = value.toInt();
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _updateProgress(index, newProgress);
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
}
