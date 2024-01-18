

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keep_clean/add_location_view.dart';
import 'package:keep_clean/main.dart';
import 'package:keep_clean/add_task_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:keep_clean/model/task.dart';
import 'package:keep_clean/task_list_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keep_clean/registration_list_page.dart';
import 'model/location.dart';
import 'notifier/setting_notifier.dart';




class SettingPage extends ConsumerWidget {

  const SettingPage({super.key});

  @override

  Widget build(BuildContext context, WidgetRef ref) {
    //final count = ref.watch(countProvider);
    final locations = ref.watch(settingPageProvider);
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
              itemCount: locations.length+1,
              itemBuilder: (context, index) {
                if(index==0){
                  return SizedBox(
                    width: size.width/2-20,
                    height: (size.width/2-20)/2,
                    child: ElevatedButton(
                        onPressed: () async{
                          final result = await showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              context: context,
                              builder: (BuildContext context) {
                            return AddLocationView();
                              }
                              );
                          if(result != null){
                            final location = Location(name: result["name"],iconName: result["iconName"]);
                            ref.read(settingPageProvider.notifier).addLocation(location);
                            ref.read(settingPageProvider.notifier).roadData();
                          };
                        },
                        style: ElevatedButton.styleFrom(
                          textStyle:  const TextStyle(
                            fontSize: 20,
                            color: Colors.black54,
                          ),
                          fixedSize: Size(size.width/2-20,(size.width/2-20)/2),
                          elevation: 10,
                          shadowColor: Colors.black54,
                          backgroundColor:  Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),


                      child : Container(

                        child: const Center(child: Icon(Icons.add,size: 50,color: Colors.black54)),

                      )
                    ),
                  );
                } else {
                  return SizedBox(
                      width: size.width/2-20,
                      height: (size.width/2-20)/2,

                      child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegistrationListPage(locations[index - 1].name, locations[index - 1].id ?? 1)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          textStyle:  const TextStyle(
                                fontSize: 20,
                                color: Colors.black54,
                            ),
                          fixedSize: Size(size.width/2-20,(size.width/2-20)/2),
                          elevation: 10,
                          shadowColor: Colors.black54,
                          backgroundColor:  Colors.white,
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          ),
                        ),

                      child: SizedBox(

                        //color: Colors.white,
                        width: double.infinity,

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(width: 9),
                            SvgPicture.asset(
                              "asset/icon/${locations[index - 1].iconName}.svg",
                              width: 30,
                              height: 25,
                              colorFilter: const ColorFilter.mode(Colors.lightBlueAccent, BlendMode.srcIn),
                            ),
                            const SizedBox(width: 15),
                            Text(
                              locations[index - 1].name,
                              style: const TextStyle(
                                color: Colors.black,  // ここでテキストの色を設定します
                                fontSize: 16,        // 任意のフォントサイズ
                            // その他のTextStyleのプロパティもここで設定できます
                              ),
                            )
                          ],
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




