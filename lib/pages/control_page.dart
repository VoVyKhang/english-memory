import 'package:flutter/material.dart';

import '../values/app_assets.dart';
import '../values/app_colors.dart';
import '../values/app_styles.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({super.key});

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  double sliderValue = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        elevation: 0,
        title: Text(
          'Your control ',
          style:
              AppStyles.h4.copyWith(color: AppColors.textColor, fontSize: 36),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset(AppAssets.leftArrow),
        ),
      ),
      body: Column(children: [
        const Spacer(),
        Text(
          'How much a number word at once',
          style:
              AppStyles.h4.copyWith(color: AppColors.lightGrey, fontSize: 18),
        ),
        const Spacer(),
        Text(
          '${sliderValue.toInt()}',
          style: AppStyles.h1.copyWith(
              color: AppColors.primaryColor,
              fontSize: 150,
              fontWeight: FontWeight.bold),
        ),
        Slider(
            value: sliderValue,
            min: 5,
            max: 100,
            divisions: 95,
            activeColor: AppColors.primaryColor,
            inactiveColor: AppColors.primaryColor,
            onChanged: (value) {
              setState(() {
                sliderValue = value;
              });
            }),
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            'slide to set',
            style: AppStyles.h5.copyWith(color: AppColors.textColor),
          ),
        ),
        const Spacer(),
        const Spacer(),
        const Spacer(),
      ]),
    );
  }
}
