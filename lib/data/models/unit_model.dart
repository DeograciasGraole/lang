class Unit {
  final int id;
  final String title;
  final String description;
  final String image;
  final int total_lessons;
  final int completed_lessons;
  final int total_percentage;

  Unit({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.total_lessons,
    required this.completed_lessons,
    required this.total_percentage,
  });

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      total_lessons: json['total_lessons'],
      total_percentage: json['total_percentage'],
      completed_lessons: json['completed_lessons'],
    );
  }
}
