import 'package:flutter_test/flutter_test.dart';
import 'package:reoretier/core/utils/result.dart';

void main() {
  group('Result', () {
    test('成功の場合のコンストラクタとgetter', () {
      const result = Result<String>(
        value: 'テスト値',
        isSucceed: true,
      );

      expect(result.value, 'テスト値');
      expect(result.isSucceed, true);
      expect(result.errorMessage, '');
    });

    test('失敗の場合のコンストラクタとgetter', () {
      const result = Result<String>(
        value: '',
        isSucceed: false,
        errorMessage: 'エラーが発生しました',
      );

      expect(result.value, '');
      expect(result.isSucceed, false);
      expect(result.errorMessage, 'エラーが発生しました');
    });

    test('null値の場合のコンストラクタとgetter', () {
      const result = Result<int?>(
        value: null,
        isSucceed: false,
        errorMessage: '値がnullです',
      );

      expect(result.value, null);
      expect(result.isSucceed, false);
      expect(result.errorMessage, '値がnullです');
    });

    test('toString - 成功の場合', () {
      const result = Result<int>(
        value: 42,
        isSucceed: true,
      );

      expect(result.toString(), 'success ::: value => 42');
    });

    test('toString - 失敗の場合', () {
      const result = Result<String>(
        value: 'テスト',
        isSucceed: false,
        errorMessage: 'エラーメッセージ',
      );

      expect(result.toString(), 'failed ::: value => テスト ::: errorMassage => エラーメッセージ');
    });
  });
}
