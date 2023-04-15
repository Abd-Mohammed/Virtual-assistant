import 'package:flutter/cupertino.dart';
import 'package:noua_virtual/pallete.dart';

class FeatureBox extends StatelessWidget {
  final Color color;
  final String text;
  final String description;

  const FeatureBox({Key? key, required this.color, required this.text, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 35,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(15.0),),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
        ).copyWith(
          left: 15.0,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                text,
                style: const TextStyle(
                  fontFamily: 'Cera Pro',
                  color: Pallete.blackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              description,
              style: const TextStyle(
                fontFamily: 'Cera Pro',
                color: Pallete.blackColor,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
