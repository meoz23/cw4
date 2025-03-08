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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adoption and Travel Plans'),
      ),
      body: Center(
        child: Text('Example of plans'),
      ),
    );
  }
}