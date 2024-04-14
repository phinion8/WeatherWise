import 'package:flutter/material.dart';

class WeatherItem extends StatelessWidget {
  const WeatherItem({super.key, required this.image, required this.title, required this.time});

  final String image;
  final String title;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(image, scale: 8,),
        SizedBox(width: 5,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: Colors.white, ),),
            SizedBox(height: 4,),
            Text(time, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ],
        )
      ],
    );
  }
}
