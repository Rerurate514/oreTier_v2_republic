import 'package:flutter_test/flutter_test.dart';
import 'package:reoretier/features/create_ranking/entities/assessment.dart';

void main() {
  group("assessment entity", () {
    test("Jsonからエンティティクラスを作成できる。", () {
      final json = {
        "id": "XXXX-XX-XXXXXXXXXXXX",
        "title": "sample test",
        "star": 3.5,
        "impressions": "sample implessions",
        "imageBytes": "byte",
        "tags": ["sample", "test"]
      };

      final assessment = Assessment.fromJson(json);
      expect(assessment.star, 3.5);
      expect(assessment.id, "XXXX-XX-XXXXXXXXXXXX");
    });

    test("AssessmentエンティティクラスからJsonを生成できる。", () {
      const Assessment assessment = Assessment(
        id: "XXXX-XX-XXXXXXXXXXXX",
        title: "sample test", 
        star: 3.5, 
        impressions: "sample implessions", 
        imageBytes: "byte",
        tags: ["sample", "test"],
      );

      final json = assessment.toJson();

      expect(json["star"], 3.5);
      expect(json["id"], "XXXX-XX-XXXXXXXXXXXX");
    });
  });
}
