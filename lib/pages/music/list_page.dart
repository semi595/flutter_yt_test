import 'package:flutter/material.dart';
import 'package:test_yt/core/constant.dart';
import 'package:test_yt/models/music_model.dart';
import 'package:test_yt/pages/music/detail_page.dart';
import 'package:test_yt/widgets/custom_button_widget.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage>
    with SingleTickerProviderStateMixin {
  late List<MusicModel> _list;
  late AnimationController _controller;
  int _playId = 3;
  bool _isPlay = true;

  @override
  void initState() {
    _list = MusicModel.list;

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this, // 垂直同步
    )..repeat(); // .. 符号回传本身

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
        title: Text(
          'Skin - Flume',
          style: TextStyle(
            color: AppColors.styleColor,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.mainColor,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButtonWidget(
                    onTap: () {},
                    child: Icon(
                      Icons.favorite,
                      color: AppColors.styleColor,
                    ),
                  ),
                  RotationTransition(
                    turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                    child: CustomButtonWidget(
                      onTap: () {
                        setState(() {
                          _isPlay = !_isPlay;
                        });
                        if (_isPlay) {
                          _controller.repeat();
                        } else {
                          _controller.stop();
                        }
                      },
                      size: 150,
                      borderWidth: 5,
                      image: 'assets/logo.jpg',
                    ),
                  ),
                  CustomButtonWidget(
                    onTap: () {},
                    child: Icon(
                      Icons.menu,
                      color: AppColors.styleColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Scrollbar(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(10, 12, 12, 25),
                    physics: BouncingScrollPhysics(),
                    itemCount: _list.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => DetailPage()));
                        },
                        selected: _list[index].id == _playId,
                        selectedTileColor: AppColors.activeColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: Text(
                          _list[index].title,
                          style: TextStyle(
                            color: AppColors.styleColor,
                          ),
                        ),
                        subtitle: Text(
                          _list[index].title,
                          style: TextStyle(
                            color: AppColors.styleColor.withAlpha(98),
                          ),
                        ),
                        trailing: CustomButtonWidget(
                          onTap: () {
                            setState(() {
                              _playId = _list[index].id;
                            });
                          },
                          isActive: _list[index].id == _playId,
                          child: Icon(
                            _list[index].id == _playId
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: _list[index].id == _playId
                                ? Colors.white
                                : AppColors.styleColor,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.mainColor.withAlpha(0),
                          AppColors.mainColor,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
