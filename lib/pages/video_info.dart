import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_yt/core/constant.dart';
import 'package:video_player/video_player.dart';

import 'home_page.dart';

class VideoInfo extends StatefulWidget {
  const VideoInfo({Key? key}) : super(key: key);

  @override
  _VideoInfoState createState() => _VideoInfoState();
}

class _VideoInfoState extends State<VideoInfo> {
  List videoInfo = [];
  bool _playArea = false;
  late VideoPlayerController _controller;

  _initData() async {
    await DefaultAssetBundle.of(context)
        .loadString('json/videoinfo.json')
        .then((value) => {
              setState(() => {videoInfo = json.decode(value)})
            });
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: !_playArea
            ? BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.gradientFirst.withOpacity(0.9),
                    AppColors.gradientSecond,
                  ],
                  begin: FractionalOffset(0.0, 0.4),
                  end: Alignment.topRight,
                ),
              )
            : BoxDecoration(color: AppColors.gradientSecond),
        child: Column(
          children: [
            !_playArea
                ? Container(
                    padding: EdgeInsets.only(top: 70, left: 30, right: 30),
                    height: 300,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            InkWell(
                              onTap: () {
                                Get.to(() => HomePage());
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                                color: AppColors.secondPageIconColor,
                              ),
                            ),
                            Expanded(child: Container()),
                            Icon(
                              Icons.info_outline,
                              size: 20,
                              color: AppColors.secondPageIconColor,
                            ),
                          ]),
                          SizedBox(height: 30),
                          Text(
                            'Legs Toning',
                            style: TextStyle(
                              fontSize: 25,
                              color: AppColors.secondPageTitleColor,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'and Glutes Workout',
                            style: TextStyle(
                              fontSize: 25,
                              color: AppColors.secondPageTitleColor,
                            ),
                          ),
                          SizedBox(height: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 90,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors
                                          .secondPageContainerGradient1stColor,
                                      AppColors
                                          .secondPageContainerGradient2ndColor,
                                    ],
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.timer,
                                      size: 20,
                                      color: AppColors.secondPageIconColor,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      '68 min',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.secondPageIconColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: 250,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors
                                          .secondPageContainerGradient1stColor,
                                      AppColors
                                          .secondPageContainerGradient2ndColor,
                                    ],
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.handyman_outlined,
                                      size: 20,
                                      color: AppColors.secondPageIconColor,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      'Resistent band, kettebell',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.secondPageIconColor,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ]),
                  )
                : Column(
                    children: [
                      Container(
                        height: 100,
                        padding:
                            const EdgeInsets.only(top: 50, left: 30, right: 30),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 20,
                                color: AppColors.secondPageTopIconColor,
                              ),
                            ),
                            Expanded(child: Container()),
                            Icon(
                              Icons.info_outline,
                              size: 20,
                              color: AppColors.secondPageTopIconColor,
                            ),
                          ],
                        ),
                      ),
                      _playView(context),
                    ],
                  ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(70)),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Row(
                      children: [
                        SizedBox(width: 30),
                        Text(
                          'Circuit 1: Legs Toning',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.circuitsColor,
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        Row(children: [
                          Icon(Icons.loop,
                              size: 20, color: AppColors.loopColor),
                          SizedBox(width: 10),
                          Text(
                            '3 sets',
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.setsColor,
                            ),
                          ),
                          SizedBox(width: 20),
                        ])
                      ],
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: _listView(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _playView(BuildContext context) {
    // if (_controller) {

    // }
    return Container();
  }

  _onTapVideo(int index) {
    final controller =
        VideoPlayerController.network(videoInfo[index]['videoUrl']);
    _controller = controller;
    setState(() {});
    controller.initialize().then((_) => {controller.play()});
  }

  Widget _listView() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
      itemCount: videoInfo.length,
      itemBuilder: (_, int index) {
        return GestureDetector(
          onTap: () {
            _onTapVideo(index);
            setState(() {
              if (_playArea == false) {
                _playArea = true;
              }
            });
          },
          child: _buildCard(index),
        );
      },
    );
  }

  Widget _buildCard(int index) {
    return Container(
      height: 135,
      width: 200,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      videoInfo[index]["thumbnail"],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Column(
                children: [
                  RichText(
                    text: TextSpan(
                        text: videoInfo[index]["title"] + '\n',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.circuitsColor,
                        ),
                        children: [
                          TextSpan(
                              text: videoInfo[index]["time"],
                              style: TextStyle(
                                fontSize: 15,
                                height: 1.8,
                                color: Colors.grey[500],
                              ))
                        ]),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 18),
          Row(
            children: [
              Container(
                width: 80,
                height: 20,
                decoration: BoxDecoration(
                  color: Color(0xFFeaeefc),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    '15s rest',
                    style: TextStyle(
                      color: Color(0xFF839fed),
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  for (int i = 0; i < 70; i++)
                    i.isEven
                        ? Container(
                            width: 3,
                            height: 1,
                            decoration: BoxDecoration(
                              color: Color(0xFF839fed),
                              borderRadius: BorderRadius.circular(2),
                            ))
                        : Container(
                            width: 3,
                            height: 1,
                            color: Colors.white,
                          )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
