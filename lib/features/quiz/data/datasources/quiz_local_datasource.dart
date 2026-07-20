import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../models/quiz_model.dart';
import '../models/quiz_progress_model.dart';

abstract class QuizLocalDataSource {
  Future<QuizModel?> getCachedQuiz();
  Future<void> cacheQuiz(QuizModel quiz);
  Future<QuizProgressModel?> getQuizProgress();
  Future<void> saveQuizProgress(QuizProgressModel progress);
  Future<void> clearQuizProgress();
}

class QuizLocalDataSourceImpl implements QuizLocalDataSource {
  static const String boxName = 'floreo_quiz_box';
  static const String keyQuiz = 'cached_quiz';
  static const String keyProgress = 'quiz_progress';

  final Map<String, dynamic> _memoryFallback = {};

  Future<Box?> _getBox() async {
    try {
      if (Hive.isBoxOpen(boxName)) {
        return Hive.box(boxName);
      }
      return await Hive.openBox(boxName);
    } catch (e) {
      debugPrint('Hive box open warning: $e. Falling back to in-memory store.');
      return null;
    }
  }

  @override
  Future<QuizModel?> getCachedQuiz() async {
    try {
      final box = await _getBox();
      if (box != null) {
        final raw = box.get(keyQuiz);
        if (raw != null && raw is Map) {
          final Map<String, dynamic> jsonMap = Map<String, dynamic>.from(raw);
          return QuizModel.fromJson(jsonMap);
        }
      } else if (_memoryFallback.containsKey(keyQuiz)) {
        return QuizModel.fromJson(
          Map<String, dynamic>.from(_memoryFallback[keyQuiz]),
        );
      }
    } catch (e) {
      debugPrint('getCachedQuiz error: $e');
    }
    return null;
  }

  @override
  Future<void> cacheQuiz(QuizModel quiz) async {
    try {
      final box = await _getBox();
      if (box != null) {
        await box.put(keyQuiz, quiz.toJson());
      } else {
        _memoryFallback[keyQuiz] = quiz.toJson();
      }
    } catch (e) {
      debugPrint('cacheQuiz error: $e');
      _memoryFallback[keyQuiz] = quiz.toJson();
    }
  }

  @override
  Future<QuizProgressModel?> getQuizProgress() async {
    try {
      final box = await _getBox();
      if (box != null) {
        final raw = box.get(keyProgress);
        if (raw != null && raw is Map) {
          final Map<String, dynamic> jsonMap = Map<String, dynamic>.from(raw);
          return QuizProgressModel.fromJson(jsonMap);
        }
      } else if (_memoryFallback.containsKey(keyProgress)) {
        return QuizProgressModel.fromJson(
          Map<String, dynamic>.from(_memoryFallback[keyProgress]),
        );
      }
    } catch (e) {
      debugPrint('getQuizProgress error: $e');
    }
    return null;
  }

  @override
  Future<void> saveQuizProgress(QuizProgressModel progress) async {
    try {
      final box = await _getBox();
      if (box != null) {
        await box.put(keyProgress, progress.toJson());
      } else {
        _memoryFallback[keyProgress] = progress.toJson();
      }
    } catch (e) {
      debugPrint('saveQuizProgress error: $e');
      _memoryFallback[keyProgress] = progress.toJson();
    }
  }

  @override
  Future<void> clearQuizProgress() async {
    try {
      final box = await _getBox();
      if (box != null) {
        await box.delete(keyProgress);
      }
      _memoryFallback.remove(keyProgress);
    } catch (e) {
      debugPrint('clearQuizProgress error: $e');
      _memoryFallback.remove(keyProgress);
    }
  }
}
