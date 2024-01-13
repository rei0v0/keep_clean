import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
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
                      onTap: () async {
                        showAddView(context);
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

  Future<dynamic> showAddView(BuildContext context) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: MediaQuery.of(context).size.width, // スクリーンの幅に合わせる
            height: MediaQuery.of(context).size.height*0.9,
            alignment: Alignment.center, // テキストを中央に配置
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20,),
                const Text("新しい場所を追加",style: TextStyle(fontSize:12,color: Colors.grey),),
                const SizedBox(height: 20,),
                Container(
                  width: MediaQuery.of(context).size.width, // スクリーンの幅に合わせる
                  height: 250,
                  child: PageView(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.5,

                          child: CreateNameView()
                      ),
                      SelectIconView()
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                Container(
                  width: 120,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(child: Text("追加",style: TextStyle(fontSize:15, fontWeight: FontWeight.bold,color: Colors.white),)),
                ),
              ],
            ),
          ),
        );
      }
    );
  }

}

class SelectIconView extends StatelessWidget {
  const SelectIconView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text("second page");
  }
}

class CreateNameView extends StatelessWidget {
  const CreateNameView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        autofocus: true,
        decoration: InputDecoration(
            hintText: 'キッチン'// 未入力時に表示されるテキスト
        ),
      ),
    );
  }
}

