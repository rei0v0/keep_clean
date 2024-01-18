import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:keep_clean/add_task_view.dart';
import 'model/task.dart';
import 'notifier/registration_list_notifier.dart';

class RegistrationListPage extends ConsumerWidget {

  const RegistrationListPage(this.placeName, this.locationId, {super.key});

  final String placeName;
  final int locationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final cleaningTasks = ref.watch(registrationListProvider(locationId));
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
        title: Text(placeName, style: const TextStyle(color: Colors.black),),
        actions: [
          IconButton(onPressed: () async {
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
            //タスクの追加
            if(result != null){
              final task = Task(name: result["name"],locationId: locationId, cycle: result["cycle"], nextDue: DateTime.now());
              ref.read(registrationListProvider(locationId).notifier).addNewTask(task);
              ref.read(registrationListProvider(locationId).notifier).fetchTasks();
            }
          }, icon: const Icon(Icons.add))
        ],

      ),
      body: Container(
        width: double.infinity,
        height: deviceSize.height,


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
                return Container(
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
                                color: Colors.lightBlueAccent,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              width: 30,
                              height: 30,
                              child: const Icon(Icons.countertops,color: Colors.white,size: 25,),
                            ),
                          ),
                          Padding(
                            padding:const EdgeInsets.fromLTRB(0, 10, 0, 5),
                            child: Text(
                              tasks[index.index].name,
                              style: TextStyle(color: Colors.black, fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 50,),
                          Text("ここに説明を記載する。",style: TextStyle(color: Colors.black, fontSize: 12),)
                        ],
                      ),
                    ],
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
    );
  }
}