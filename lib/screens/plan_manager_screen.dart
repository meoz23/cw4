import 'package:flutter/material.dart';
import '../models/plan.dart';

class PlanManagerScreen extends StatefulWidget {
  @override
  _PlanManagerScreenState createState() => _PlanManagerScreenState();
}

class _PlanManagerScreenState extends State<PlanManagerScreen> {
  List<Plan> plans = [];

  void addPlan(String name, String description) {
    setState(() {
      plans.add(Plan(name: name, description: description));
    });
  }

  void updatePlan(int index, String newName, String newDescription) {
    setState(() {
      plans[index].name = newName;
      plans[index].description = newDescription;
    });
  }

  void completePlan(int index) {
    setState(() {
      plans[index].isCompleted = !plans[index].isCompleted;
    });
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
          return ListTile(
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
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
        },
        child: Icon(Icons.add),
      ),
    );
  }
}