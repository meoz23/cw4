class Plan {
  String name;
  String description;
  bool isCompleted;

  Plan({
    required this.name,
    required this.description,
    this.isCompleted = false,
  });
}