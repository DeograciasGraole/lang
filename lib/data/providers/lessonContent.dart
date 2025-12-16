import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lang/data/models/lessonContent.dart';
import 'package:lang/data/providers/tokenSave.dart';
import 'package:lang/data/services/ApiService.dart';

final lessonsContentProvider =
    FutureProvider.family<List<LessonContent>, (int, int)>((ref, params) async {
      final unitId = params.$1;
      final lessonId = params.$2;

      final token = ref.watch(tokenNotifierProvider);
      final apiService = ApiService(
        token: token,
      ); // or get it via another provider if you have one
      return apiService.fetchLessonsContentByLessonUnit(unitId, lessonId);
    });
