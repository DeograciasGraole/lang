class Quiz {
  final int id;
  final int lessonId;
  final int languageId;
  final String question;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String correctOption;
  final String? image;

  Quiz({
    required this.id,
    required this.lessonId,
    required this.languageId,
    required this.question,
    required this.optionA,
    required this.optionB,
    required this.optionC,
    required this.optionD,
    required this.correctOption,
    this.image,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json['id'],
      lessonId: json['lesson_id'],
      languageId: json['language_id'],
      question: json['question'] ?? '',
      optionA: json['option_a'] ?? '',
      optionB: json['option_b'] ?? '',
      optionC: json['option_c'] ?? '',
      optionD: json['option_d'] ?? '',
      correctOption: json['correct_option'] ?? '',
      image: json['image'],
    );
  }
}
