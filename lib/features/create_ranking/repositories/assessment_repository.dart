import '../entities/assessment.dart';

abstract class AssessmentRepository {
  Future<bool> createAssessment(Assessment assessment);
  Future<bool> updateAssessment(Assessment assessment);
  Future<bool> deleteAssessment(Assessment assessment);
  Future<Assessment?> fetchAssessment(String id);
  Future<List<Assessment>?> fetchAll();
}
