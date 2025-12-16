import 'package:lang/data/models/grammars_model.dart';
import 'package:lang/data/models/quiz_model.dart';
import 'package:lang/data/models/vocabulary_model.dart';

class LessonContent {
  final int id;
  final int unitId;
  final int languageId;
  final String title;
  final String description;
  final int order;
  final List<Vocabulary> vocabularies;
  final List<Grammar> grammars;
  final List<Quiz> quizzes;

  LessonContent({
    required this.id,
    required this.unitId,
    required this.languageId,
    required this.title,
    required this.description,
    required this.order,
    required this.vocabularies,
    required this.grammars,
    required this.quizzes,
  });

  factory LessonContent.fromJson(Map<String, dynamic> json) {
    return LessonContent(
      id: json['id'],
      unitId: json['unit_id'],
      languageId: json['language_id'],
      title: json['title'] ?? json['name'] ?? '',
      description: json['content'] ?? '',
      order: json['order'] ?? 0,
      vocabularies:
          (json['vocabularies'] as List<dynamic>?)
              ?.map((v) => Vocabulary.fromJson(v))
              .toList() ??
          [],
      grammars:
          (json['grammars'] as List<dynamic>?)
              ?.map((g) => Grammar.fromJson(g))
              .toList() ??
          [],
      quizzes:
          (json['quizzes'] as List<dynamic>?)
              ?.map((q) => Quiz.fromJson(q))
              .toList() ??
          [],
    );
  }
}
