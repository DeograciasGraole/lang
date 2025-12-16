import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lang/data/models/lessons_model.dart';
import 'package:lang/data/providers/tokenSave.dart';
import 'package:lang/data/services/ApiService.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  final token = ref.watch(tokenNotifierProvider);
  return ApiService(token: token);
});
final lessonsByUnitProvider = FutureProvider.family<List<Lesson>, int>((
  ref,
  unitId,
) {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.fetchLessonsByUnit(unitId);
});
