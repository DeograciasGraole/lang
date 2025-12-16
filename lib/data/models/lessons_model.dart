class Lesson {
  final int id;
  final int unitId;
  final int languageId;
  final String title;
  final String description;
  final int order;

  // User progress fields
  final double? progressPercentage;
  final bool? completed;

  Lesson({
    required this.id,
    required this.unitId,
    required this.languageId,
    required this.title,
    required this.description,
    required this.order,
    this.progressPercentage,
    this.completed,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    // progress is an object (Map), not a list
    final progress = json['progress'] as Map<String, dynamic>?;

    return Lesson(
      id: json['id'],
      unitId: json['unit_id'],
      languageId: json['language_id'],
      title: json['title'] ?? json['name'] ?? '',
      description: json['content'] ?? '',
      order: json['order'],
      progressPercentage: progress != null
          ? (progress['progress_percentage'] as num).toDouble()
          : null,
      completed: progress != null ? progress['completed'] == 1 : null,
    );
  }

  @override
  String toString() {
    return 'Lesson(id: $id, title: $title, order: $order, progress: ${progressPercentage ?? 0}, completed: ${completed ?? false})';
  }
}
