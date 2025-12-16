class Vocabulary {
  final int id;
  final String wordEn;
  final String wordTr;
  final String exampleEn;
  final String exampleTr;
  final String? image;

  Vocabulary({
    required this.id,
    required this.wordEn,
    required this.wordTr,
    required this.exampleEn,
    required this.exampleTr,
    this.image,
  });

  factory Vocabulary.fromJson(Map<String, dynamic> json) {
    return Vocabulary(
      id: json['id'],
      wordEn: json['word_en'] ?? '',
      wordTr: json['word_tr'] ?? '',
      exampleEn: json['example_en'] ?? '',
      exampleTr: json['example_tr'] ?? '',
      image: json['image'],
    );
  }
}
