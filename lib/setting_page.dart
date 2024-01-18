import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keep_clean/add_location_view.dart';
import 'package:keep_clean/main.dart';
import 'package:keep_clean/add_task_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:keep_clean/model/task.dart';
import 'package:keep_clean/task_list_page.dart';

import 'notifier/setting_notifier.dart';



class SettingPage extends ConsumerWidget {

  const SettingPage({super.key});

  @override

  Widget build(BuildContext context, WidgetRef ref) {
    //final count = ref.watch(countProvider);
    final settingList = ref.watch(settingPageProvider);
    final Size size = MediaQuery.of(context).size;
    final buttonsize_x=size.width/2-20;
    final buttonsize_y=buttonsize_x/2;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
            width: size.width,
            height: size.height,
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 7 / 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  crossAxisCount:2
              ),
              itemCount: settingList.locations.length+1,
              itemBuilder: (context, index) {
                if(index==0){
                  return SizedBox(
                    width: size.width/2-20,
                    height: (size.width/2-20)/2,
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return AddLocationView();
                          }
                        );

                      },
                      child : Container(

                        child: Center(child: Icon(Icons.add,size: 50,color: Colors.black54)),

                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(1,1),
                            )
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),

                          /*border: Border.all(
                            color: Colors.black12,  // 線の色を指定
                            width: 1.0,         // 線の太さを指定
                          ),*/

                        ),

                      )
                    ),
                  );
                }
                else {
                  return
                    SizedBox(
                      width: size.width/2-20,
                      height: (size.width/2-20)/2,

                      child: ElevatedButton(
                      onPressed: () {
                        // ボタンが押されたときの処理
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=> TaskListPage(settingList.locations[index - 1].name))
                        );

                      },

                      child: Container(

                        //color: Colors.white,
                        width: double.infinity,

                        child: Row(

                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(width: 9),

                            SvgPicture.asset(

                              "asset/img/toilet1.svg",
                              width: 30,
                              height: 25,
                              color: Colors.lightBlueAccent,



                            ),
                            SizedBox(width: 15),
                            Text(
                              settingList.locations[index - 1].name,
                              style: TextStyle(
                                color: Colors.black,  // ここでテキストの色を設定します
                                fontSize: 16,        // 任意のフォントサイズ
                            // その他のTextStyleのプロパティもここで設定できます
                              ),
                            )
                          ],
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                          textStyle:  const TextStyle(
                                fontSize: 20,
                                color: Colors.black54,
                            ),


                          fixedSize: Size(size.width/2-20,(size.width/2-20)/2),

                          elevation: 10,
                          shadowColor: Colors.black54,

                          /*side: BorderSide(
                            color: Colors.black12,
                            width: 1,
                          ),*/
                          //backgroundColor: Color(0xFFf5f5f5),
                          backgroundColor:  Colors.white,
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    );
                }
              },
            )
        )

    );
  }



}




