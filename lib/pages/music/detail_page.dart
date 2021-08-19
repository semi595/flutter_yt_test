import 'package:flutter/material.dart';
import 'package:test_yt/core/constant.dart';
import 'package:test_yt/widgets/custom_button_widget.dart';
import 'package:test_yt/widgets/custom_progress_widget.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>
    with SingleTickerProviderStateMixin {
  late double _value;
  late AnimationController _controller;
  bool _isPlay = true;

  @override
  void initState() {
    _value = 0.0;
    _controller = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Column(
        children: [
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButtonWidget(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.arrow_back, color: AppColors.styleColor),
                ),
                Text('Play Now',
                    style: TextStyle(
                      color: AppColors.styleColor,
                      fontWeight: FontWeight.bold,
                    )),
                CustomButtonWidget(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(Icons.menu, color: AppColors.styleColor),
                ),
              ],
            ),
          ),
          CustomButtonWidget(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => DetailPage()));
            },
            size: MediaQuery.of(context).size.width * .7,
            borderWidth: 5,
            image: 'assets/logo.jpg',
          ),
          Text(
            'Fulme',
            style: TextStyle(
              color: AppColors.styleColor,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              height: 2,
            ),
          ),
          Text(
            'Fulne - KUCCK',
            style: TextStyle(
              color: AppColors.styleColor.withAlpha(90),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: CustomProgressWidget(
              value: _value,
              labelStart: '0:00',
              labelEnd: '3:46',
            ),
          ),
          Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButtonWidget(
                onTap: () {
                  setState(() {
                    if (_value >= 0.1) {
                      _value -= 0.1;
                    }
                  });
                },
                size: 80,
                borderWidth: 5,
                child: Icon(Icons.fast_rewind,
                    size: 30, color: AppColors.styleColor),
              ),
              CustomButtonWidget(
                onTap: () {
                  if (_controller.value == 0.0) {
                    _controller.forward();
                    setState(() {
                      _isPlay = false;
                    });
                  } else {
                    _controller.reverse();
                    setState(() {
                      _isPlay = true;
                    });
                  }
                },
                size: 80,
                borderWidth: 5,
                isActive: _isPlay,
                child: AnimatedIcon(
                  progress: _controller,
                  icon: AnimatedIcons.pause_play,
                  size: 30,
                  color: _isPlay ? Colors.white : AppColors.styleColor,
                ),
              ),
              CustomButtonWidget(
                onTap: () {
                  setState(() {
                    if (_value <= 0.9) {
                      _value += 0.1;
                    }
                  });
                },
                size: 80,
                borderWidth: 5,
                child: Icon(Icons.fast_forward,
                    size: 30, color: AppColors.styleColor),
              ),
            ],
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }
}
