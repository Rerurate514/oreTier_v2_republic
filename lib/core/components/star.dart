import 'package:flutter/material.dart';

class Star extends StatelessWidget{
  final double star;
  final double starSize;
  final int maxStar;

  const Star({
    super.key, 
    required this.star, 
    this.starSize = 24, 
    this.maxStar = 5
  });

  @override
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: star * starSize,
          height: starSize,
          child: ClipRect(
            child: FittedBox(
              alignment: Alignment.centerLeft,
              fit: BoxFit.none,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for(int i = 0; i < maxStar; i++) const Icon(Icons.star, size: 24, color: Colors.amber,)
                ],
              ),
            ),
          )
        ),
        SizedBox(
          width: (maxStar - star) * starSize,
        )
      ],
    );
  }
}
