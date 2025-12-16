import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lang/data/providers/LessonProvider.dart';

// A provider that calls the userProgress method with parameters
final userProgressProvider =
    FutureProvider.family<Map<String, dynamic>, UserProgressParams>((
      ref,
      params,
    ) async {
      final api = ref.watch(apiServiceProvider);
      return api.userProgress(
        params.lessonId,
        params.completed,
        params.percentage,
      );
    });

// Helper class to hold the parameters
class UserProgressParams {
  final int lessonId;
  final bool completed;
  final int percentage;

  UserProgressParams({
    required this.lessonId,
    required this.completed,
    required this.percentage,
  });
}
