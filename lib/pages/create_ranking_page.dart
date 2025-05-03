import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../core/components/padding_border.dart';
import '../core/components/standard_padding.dart';
import '../core/utils/show_success_dialog.dart';
import '../core/utils/show_warn_dialog.dart';
import '../features/create_ranking/components/image_picker.dart';
import '../features/create_ranking/components/image_selector_overlay.dart';
import '../features/create_ranking/components/impression_form.dart';
import '../features/create_ranking/components/star_rating.dart';
import '../features/create_ranking/components/submit_button.dart';
import '../features/create_ranking/components/title_form.dart';
import '../features/create_ranking/entities/assessment.dart';
import '../features/create_ranking/providers/is_show_image_provider.dart';
import '../features/create_ranking/providers/star_provider.dart';
import '../features/create_ranking/viewModels/assessment_notifier.dart';

class CreateRankingPage extends ConsumerStatefulWidget {
  const CreateRankingPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateRankingPageState();
}

class _CreateRankingPageState extends ConsumerState<CreateRankingPage> {
  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _impressionTextController = TextEditingController();

  String _pictureBase64 = "";

  Future<void> createAssesment() async {    
    final Assessment assesment = Assessment(
      id: const Uuid().v4(), 
      title: _titleTextController.text,
      star: ref.watch(starProvider.notifier).state,
      impressions: _impressionTextController.text,
      imageBytes: _pictureBase64, 
    );

    final bool isSucceed = await ref.watch(assessmentNotifierProvider.notifier).createAssessment(assesment);

    if(isSucceed){
      // ignore: use_build_context_synchronously
      showSuccessDialog(context, "作成に成功しました!");
    }
    else{
      // ignore: use_build_context_synchronously
      showWarnDialog(context, "作成に失敗しました!");
    }
  }

  void finishCreatingImage(String pictureBase64){
    setState(() {
      _pictureBase64 = pictureBase64;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: ref.watch(isShowImageProvider.notifier).state
            ? const NeverScrollableScrollPhysics()
            : const ScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: Column(
                children: [
                  const StandardPadding(),
                  buildTitle(),
                  const PaddingBorder(),
                  const ImagePicker(),
                  const StandardPadding(),
                  TitleForm(textController: _titleTextController),
                  const StandardPadding(),
                  ImpressionForm(textController: _impressionTextController),
                  const StandardPadding(),
                  const StarRating(),
                  const StandardPadding(),
                  SubmitButton(
                    createAssesment: () => createAssesment(),
                  ),
                  const StandardPadding()
                ],
              ),
            ),
          ),
          ImageSelectorOverlay(
            finishCreatingImageCallback: finishCreatingImage,
          )
        ],
      )
    );
  }

  Widget buildTitle(){
    return const Text(
      "評価シートの作成",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 23
      ),
    );
  }
}
