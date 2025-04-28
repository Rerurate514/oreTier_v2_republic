import '../entities/assessment.dart';
import '../repositories/assessment_repository.dart';

final List<Assessment> assessments = [];

class AssessmentDataSourceWithGlobalState implements AssessmentRepository {
  @override
  Future<bool> createAssessment(Assessment assessment) async {
    try{
      assessments.add(assessment);
      return true;
    }
    catch(e){
      return false;
    }
  }

  @override
  Future<bool> deleteAssessment(Assessment assessment) async {
    return assessments.remove(assessment);
  }

  @override
  Future<List<Assessment>> fetchAll() async {
    return assessments;
  }

  @override
  Future<Assessment?> fetchAssessment(String id) async {
    for (final Assessment assess in assessments) {
      if(assess.id == id) return assess;
    }

    return null;
  }

  @override
  Future<bool> updateAssessment(Assessment assessment) async {
    for (final (int index, Assessment assess) in assessments.indexed) {
      if(assessment.id == assess.id) {
        assessments[index] = assessment;
      }
    }

    return false;
  }
  
}
