class Grammar {
  final int id;
  final int lessonId;
  final int languageId;
  final String title;
  final String description;
  final String sentenceEn;
  final String sentenceTr;
  final String note;
  final String? image;

  Grammar({
    required this.id,
    required this.lessonId,
    required this.languageId,
    required this.title,
    required this.description,
    required this.sentenceEn,
    required this.sentenceTr,
    required this.note,
    this.image,
  });

  factory Grammar.fromJson(Map<String, dynamic> json) {
    return Grammar(
      id: json['id'],
      lessonId: json['lesson_id'],
      languageId: json['language_id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      sentenceEn: json['sentence_en'] ?? '',
      sentenceTr: json['sentence_tr'] ?? '',
      note: json['note'] ?? '',
      image: json['image'],
    );
  }
}
