import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/components/h2_text.dart';
import '../../../core/components/star.dart';
import '../providers/star_provider.dart';

class StarRating extends ConsumerStatefulWidget {
  const StarRating({super.key});

  @override
  ConsumerState<StarRating> createState() => _StarRatingState();
}

class _StarRatingState extends ConsumerState<StarRating> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final starValue = ref.watch(starProvider.notifier).state;

    return Column(
      children: [
        const H2Text("最後に数字で評価！"),
        SizedBox(height: size.height * 0.005),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: Color.fromRGBO((51 * starValue).toInt(), 0, (255 - 51 * starValue).toInt(), 1),
            thumbColor: Color.fromRGBO((51 * starValue).toInt(), 0, (255 - 51 * starValue).toInt(), 1)
          ),
          child: Slider(
            value: starValue, 
            onChanged: (value) {
              setState(() {
                ref.watch(starProvider.notifier).state = double.parse(value.toStringAsFixed(1));
              });
            },
            max: 5,
            divisions: 50,
          )
        ),
        SizedBox(height: size.height * 0.005),
        Row(
          children: [
            Text(
              "評価：$starValue",
              style: const TextStyle(fontSize: 32),
            ),
            SizedBox(width: size.width * 0.1),
            Star(star: starValue)
          ],
        )
      ],
    );
  }
}
