import 'package:flutter/material.dart';
import 'package:test_yt/core/constant.dart';

class CustomButtonWidget extends StatelessWidget {
  final Widget? child;
  final double size;
  final double borderWidth;
  final String? image;
  final bool isActive;
  final VoidCallback onTap;

  const CustomButtonWidget({
    Key? key,
    required this.onTap,
    this.child,
    this.size = 50,
    this.borderWidth = 2,
    this.image,
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(200)),
      border: Border.all(
        width: borderWidth,
        color: isActive ? AppColors.darkBlue : AppColors.mainColor,
      ),
      boxShadow: [
        BoxShadow(
          color: AppColors.lightBlueShadow,
          blurRadius: 10,
          offset: Offset(5, 5),
          spreadRadius: 3,
        ),
        BoxShadow(
          color: Colors.white60,
          blurRadius: 10,
          offset: Offset(-5, -5),
          spreadRadius: 3,
        ),
      ],
    );

    if (image != null) {
      boxDecoration = boxDecoration.copyWith(
        image: DecorationImage(
          image: ExactAssetImage(image!),
          fit: BoxFit.cover,
        ),
      );
    }

    if (isActive) {
      boxDecoration = boxDecoration.copyWith(
        gradient: RadialGradient(
          colors: [
            AppColors.lightBlue,
            AppColors.darkBlue,
          ],
        ),
      );
    } else {
      boxDecoration = boxDecoration.copyWith(
        gradient: RadialGradient(
          colors: [
            AppColors.mainColor,
            AppColors.mainColor,
            AppColors.mainColor,
            Colors.white,
          ],
        ),
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: boxDecoration,
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
            EdgeInsets.all(0),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(200),
            ),
          ),
        ),
        onPressed: onTap,
        child: child ?? Container(),
      ),
    );
  }
}
