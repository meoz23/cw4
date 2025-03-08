class Plan {
  String name;
  String description;
  bool isCompleted;
  DateTime date;

  Plan({
    required this.name,
    required this.description,
    this.isCompleted = false,
    required this.date,
  });
}