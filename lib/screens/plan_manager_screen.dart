import 'package:flutter/material.dart';
import '../models/plan.dart';

class PlanManagerScreen extends StatefulWidget {
  const PlanManagerScreen({super.key});

  @override
  PlanManagerScreenState createState() => PlanManagerScreenState();
}

class PlanManagerScreenState extends State<PlanManagerScreen> {
  List<Plan> plans = [];

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  void addPlan(String name, String description, DateTime date) {
    setState(() {
      plans.add(Plan(name: name, description: description, date: date));
    });
  }

  void _showCreatePlanDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Create New Plan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Plan Name'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              ListTile(
                title: Text('Date: ${selectedDate.toLocal()}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != selectedDate) {
                    setState(() {
                      selectedDate = picked;
                    });
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                addPlan(
                  nameController.text,
                  descriptionController.text,
                  selectedDate,
                );
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void completePlan(int index) {
    setState(() {
      plans[index].isCompleted = !plans[index].isCompleted;
    });
  }

  void editPlan(int index) {
    nameController.text = plans[index].name;
    descriptionController.text = plans[index].description;
    selectedDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Plan'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Plan Name'),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              ListTile(
                title: Text('Date: ${selectedDate.toLocal()}'),
                trailing: Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != selectedDate)
                    setState(() {
                      selectedDate = picked;
                    });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  plans[index].name = nameController.text;
                  plans[index].description = descriptionController.text;
                  plans[index].date = selectedDate;
                });
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void removePlan(int index) {
    setState(() {
      plans.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adoption and Travel Plans'),
      ),
      body: ListView.builder(
        itemCount: plans.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onDoubleTap: () {
              removePlan(index);
            },
            child: ListTile(
              title: Text(
                plans[index].name,
                style: TextStyle(
                  decoration: plans[index].isCompleted
                      ? TextDecoration.lineThrough
                      : null,
                ),
              ),
              subtitle: Text(plans[index].description),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  removePlan(index);
                },
              ),
              onTap: () {
                completePlan(index);
              },
              onLongPress: () {
                editPlan(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreatePlanDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}