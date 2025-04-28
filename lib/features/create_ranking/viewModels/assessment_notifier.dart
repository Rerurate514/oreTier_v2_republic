import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dataSources/assessmentDataSourceWithGlobalState.dart';
import '../entities/assessment.dart';
import '../repositories/assessment_repository.dart';

final StateNotifierProvider<AssessmentNotifier, List<Assessment>> assessmentNotifierProvider = StateNotifierProvider<AssessmentNotifier, List<Assessment>>((ref) {
  return AssessmentNotifier(AssessmentDataSourceWithGlobalState());
});

class AssessmentNotifier extends StateNotifier<List<Assessment>> implements AssessmentRepository{
  final AssessmentDataSourceWithGlobalState _assessmentDataSource;

  AssessmentNotifier(this._assessmentDataSource) : super (<Assessment>[]);
  
  @override
  Future<bool> createAssessment(Assessment assessment) async {
    try{
      return await _assessmentDataSource.createAssessment(assessment);
    }
    catch(e){
      e.toString();
      return false;
    }
  }
  
  @override
  Future<bool> deleteAssessment(Assessment assessment) async {
    try{
      return await _assessmentDataSource.deleteAssessment(assessment);
    }
    catch(e){
      e.toString();
      return false;
    }
  }
  
  @override
  Future<List<Assessment>?> fetchAll() async {
    try{
      return await _assessmentDataSource.fetchAll();
    }
    catch(e){
      e.toString();
      return null;
    }
  }
  
  @override
  Future<Assessment?> fetchAssessment(String id) async {
    try{
      return await _assessmentDataSource.fetchAssessment(id);
    }
    catch(e){
      e.toString();
      return null;
    }
  }
  
  @override
  Future<bool> updateAssessment(Assessment assessment) async {
    try{
      return await _assessmentDataSource.updateAssessment(assessment);
    }
    catch(e){
      e.toString();
      return false;
    }
  }
}
