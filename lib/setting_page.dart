import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keep_clean/add_task_view.dart';
import 'package:keep_clean/main.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:keep_clean/model/task.dart';

import 'notifier/setting_notifier.dart';



class SettingPage extends ConsumerWidget {

  const SettingPage({super.key});

  @override

  Widget build(BuildContext context, WidgetRef ref) {
    //final count = ref.watch(countProvider);
    final settingList = ref.watch(settingPageProvider);
    final Size size = MediaQuery.of(context).size;
    final x=size.width/2-20;
    final y=x/2;
    return Scaffold(
        appBar: AppBar(
            centerTitle: false,
            title: Text("そうじ場所"),
            actions: [
              Container(
                width: 50,
                height: 50,
                child: Ink(
                  decoration: ShapeDecoration(
                    color: Colors.white, // + ボタンの背景色
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.add,
                      size: 30,
                      color: Colors.black, // + ボタンのアイコンの色
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        isScrollControlled: true, // 画面半分よりも大きなモーダルの表示設定
                        builder: (BuildContext context) {
                          return AddTaskView();
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      side: BorderSide(
                        color: Colors.black, //枠線の色
                        width: 2, //枠線の太さ
                      ),
                    ),
                  ),
                ),
              ),
            ]
        ),
        body: Container(
            width: size.width,
            height: size.height,
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  crossAxisCount:2
              ),
              itemCount: settingList.locations.length,
              itemBuilder: (context, index) {
                return ElevatedButton(
                  onPressed: () {
                    // ボタンが押されたときの処理
                    print('Buttonpressed');
                  },
                  child: Container(
                    //color: Colors.white,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "asset/img/toilet1.svg",
                          width: 80,
                          height: 70,
                          color: Colors.greenAccent,


                        ),
                        Text(settingList.locations[index].name),
                      ],
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 30),
                    fixedSize: Size(x, x),
                    elevation: 0.0,

                    side: BorderSide(
                      color: Colors.black12,
                      width: 1,
                    ),
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                );
              },
            )
        )

    );
  }

}

