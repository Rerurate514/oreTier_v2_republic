import 'package:freezed_annotation/freezed_annotation.dart';

part 'assessment.freezed.dart';
part 'assessment.g.dart';

@freezed
abstract class Assessment with _$Assessment {
  const factory Assessment({
    required String id, 
    required String title,
    required double star,
    required String impressions,
    required String imageBytes,
    @Default([]) List<String> tags
  }) = _Assessment;

  factory Assessment.fromJson(Map<String, dynamic> json) => _$AssessmentFromJson(json);
}
