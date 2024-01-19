import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:keep_clean/add_task_view.dart';
import 'model/location.dart';
import 'model/task.dart';
import 'notifier/cleaning_list_notifier.dart';
import 'notifier/registration_list_notifier.dart';
import 'notifier/setting_notifier.dart';

class RegistrationListPage extends ConsumerWidget {

  const RegistrationListPage(this.location, {super.key});

  final Location location;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final cleaningTasks = ref.watch(registrationListProvider(location.id ?? 0));
    final deviceSize = MediaQuery.of(context).size;
    final List<String> cyclesInJp = ["毎日","２日に1回","3日に一回","週に1回","2週に1回","月に1回","毎週日曜","毎週月曜","毎週火曜","毎週水曜","毎週木曜","毎週金曜","毎週土曜"];
    final List<String> cycles = [
      "Daily", "Bi-daily", "Tri-daily", "Weekly", "Bi-weekly", "Monthly",
      "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(location.name, style: const TextStyle(color: Colors.black),),
        actions: [
          IconButton(
              onPressed: () async {
                final result = await showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  enableDrag: true,
                  barrierColor: Colors.black.withOpacity(0.5),
                  builder: (context){
                    return const AddTaskView();
                  }
                );
                if(result != null){
                  final task = Task(name: result["name"],locationId: location.id ?? 0, cycle: result["cycle"], nextDue: result["initialDate"]);
                  ref.read(registrationListProvider(location.id ?? 0).notifier).addNewTask(task);
                  ref.read(registrationListProvider(location.id ?? 0).notifier).fetchTasks();
                  ref.invalidate(cleaningListProvider);
                }
          }, icon: const Icon(Icons.add)),
        ],


      ),
      body: Container(
        width: double.infinity,
        height: deviceSize.height,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Stack(
          children: [
            if(cleaningTasks.isEmpty) const Center(child: Text("登録された掃除タスクはありません")),
            GroupListView(
              sectionsCount: cycles.length,
              countOfItemInSection: (int section) {
                return cleaningTasks.where((task) => task.cycle == cycles[section]).toList().length;
              },
              groupHeaderBuilder: (BuildContext context, int section) {
                final taskNum = cleaningTasks.where((task) => task.cycle == cycles[section]).toList().length;
                return taskNum == 0 ? const SizedBox() : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Text(
                    cyclesInJp[section],
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                );
              },
              itemBuilder: (BuildContext context, IndexPath index) {
                final tasks = cleaningTasks.where((task) => task.cycle == cycles[index.section]).toList();
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12, //色
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                width: 30,
                                height: 30,
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: SvgPicture.asset(
                                    "asset/icon/${location.iconName}.svg",
                                    colorFilter: const ColorFilter.mode(Colors.lightBlueAccent, BlendMode.srcIn),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding:const EdgeInsets.fromLTRB(0, 10, 0, 5),
                              child: Text(
                                location.name,
                                style: const TextStyle(color: Colors.black, fontSize: 13),
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () async {
                                await showDialog(
                                    context: context,
                                    builder: (_) {
                                      return SimpleDialog(
                                        contentPadding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        backgroundColor: Colors.white.withOpacity(0.95),
                                        surfaceTintColor: Colors.transparent,
                                        title: Column(
                                          children: [
                                            Text(tasks[index.index].name,style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                                            const SizedBox(height: 5,),
                                            const Text("削除しますか？", style: TextStyle(fontSize: 13,)),
                                            const SizedBox(height: 13,),
                                          ],
                                        ),
                                        children: [
                                          Row(
                                            children: [
                                              Expanded( // Expandedウィジェットを追加
                                                child: Container(
                                                  height: 50,
                                                  decoration: const BoxDecoration(
                                                    border: Border(
                                                      top: BorderSide(
                                                        color: Color(0xffdcdcdc),
                                                        width: 1,
                                                      ),
                                                      right: BorderSide(
                                                        color: Color(0xffdcdcdc),
                                                        width: 1,
                                                      ),
                                                    ),
                                                    borderRadius: BorderRadius.only(
                                                      bottomLeft: Radius.circular(20),
                                                    ),
                                                  ),
                                                  child: SimpleDialogOption(
                                                    child: const Center(child: Text('キャンセル', style: TextStyle(color: Colors.lightBlue),)),
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                ),
                                              ),
                                              Expanded( // Expandedウィジェットを追加
                                                child: Container(
                                                  height: 50,
                                                  decoration: const BoxDecoration(
                                                    border: Border(
                                                      top: BorderSide(
                                                        color: Color(0xffdcdcdc),
                                                        width: 1,
                                                      ),
                                                    ),
                                                    borderRadius: BorderRadius.only(
                                                      bottomRight: Radius.circular(20),
                                                    ),
                                                  ),
                                                  child: SimpleDialogOption(
                                                    child: const Center(child: Text('削除', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),)),
                                                    onPressed: () {
                                                      ref.read(registrationListProvider(location.id ?? 0).notifier).deleteTask(tasks[index.index]);
                                                      ref.invalidate(registrationListProvider(location.id ?? 0));
                                                      ref.invalidate(cleaningListProvider);
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );

                                    });
                              },
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(Icons.delete,color: Colors.grey,),
                                )
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const SizedBox(width: 50,),
                            Text(tasks[index.index].name,style: const TextStyle(color: Colors.black, fontSize: 12),)
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              sectionSeparatorBuilder: (context, section) {
                final taskNum = cleaningTasks.where((task) => task.cycle == cycles[section]).toList().length;
                return taskNum == 0 ? const SizedBox() : const SizedBox(height:10);
              }
          ),
          ],

        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () async {
              await showDialog(
                  context: context,
                  builder: (_) {
                    return SimpleDialog(
                      contentPadding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Colors.white.withOpacity(0.95),
                      surfaceTintColor: Colors.transparent,
                      title: Column(
                        children: [
                          Text(location.name,style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                          const SizedBox(height: 5,),
                          const Text("削除しますか？", style: TextStyle(fontSize: 13,)),
                          const SizedBox(height: 13,),
                        ],
                      ),
                      children: [
                        Row(
                          children: [
                            Expanded( // Expandedウィジェットを追加
                              child: Container(
                                height: 50,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: Color(0xffdcdcdc),
                                      width: 1,
                                    ),
                                    right: BorderSide(
                                      color: Color(0xffdcdcdc),
                                      width: 1,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                  ),
                                ),
                                child: SimpleDialogOption(
                                  child: const Center(child: Text('キャンセル', style: TextStyle(color: Colors.lightBlue),)),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ),
                            Expanded( // Expandedウィジェットを追加
                              child: Container(
                                height: 50,
                                decoration: const BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                      color: Color(0xffdcdcdc),
                                      width: 1,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                                child: SimpleDialogOption(
                                  child: const Center(child: Text('削除', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),)),
                                  onPressed: () {
                                    ref.read(registrationListProvider(location.id ?? 0).notifier).deleteLocation(location);
                                    ref.invalidate(settingPageProvider);
                                    ref.invalidate(cleaningListProvider);
                                    Navigator.of(context).popUntil((route) => route.isFirst);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );

                  });

            },
            child: Container(
              height: 60,
              width: double.infinity,
              decoration:  BoxDecoration(
                color: Colors.orangeAccent,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text("${location.name}を削除する",style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),),
              ),
            ),
          ),
        ),
      )
    );
  }
}