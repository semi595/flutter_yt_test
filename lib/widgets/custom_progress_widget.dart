import 'package:flutter/material.dart';
import 'package:test_yt/core/constant.dart';
import 'package:test_yt/widgets/custom_button_widget.dart';

class CustomProgressWidget extends StatelessWidget {
  final double value;
  final String labelStart;
  final String labelEnd;
  const CustomProgressWidget(
      {Key? key,
      required this.labelStart,
      required this.labelEnd,
      required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: 50,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  labelStart,
                  style: TextStyle(color: AppColors.styleColor),
                ),
                Text(
                  labelEnd,
                  style: TextStyle(color: AppColors.styleColor),
                ),
              ],
            ),
          ),
          _miniProgress(width),
          _progressValue(width * value),
          _indicatorButton(width * value < 30 ? 30 : width * value),
        ],
      ),
    );
  }

  Widget _indicatorButton(double width) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: 40,
        width: width,
        child: Row(children: [
          Expanded(
            child: SizedBox(),
          ),
          CustomButtonWidget(
              onTap: () {},
              size: 30,
              borderWidth: 1,
              child: Icon(
                Icons.fiber_manual_record,
                size: 20,
                color: AppColors.darkBlue,
              )),
        ]),
      ),
    );
  }

  Widget _progressValue(double width) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: 5,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.lightBlue,
          border: Border.all(
            color: AppColors.styleColor.withAlpha(90),
            width: .5,
          ),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
      ),
    );
  }

  Widget _miniProgress(double width) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: 5,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          border: Border.all(
            color: AppColors.styleColor.withAlpha(90),
            width: .5,
          ),
          borderRadius: BorderRadius.all(Radius.circular(50)),
          boxShadow: [
            BoxShadow(
              color: AppColors.styleColor.withAlpha(90),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, -1),
            )
          ],
        ),
      ),
    );
  }
}
