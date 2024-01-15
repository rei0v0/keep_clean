import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:keep_clean/model/task.dart';
import 'package:keep_clean/notifier/cleaning_list_notifier.dart';
import 'package:group_list_view/group_list_view.dart';


class CleaningListPage extends ConsumerWidget {

  const CleaningListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final deviceSize = MediaQuery.of(context).size;
    final cleaningList = ref.watch(cleaningListProvider);
    final cleaningListNotifier = ref.watch(cleaningListProvider.notifier);
    final title = ['期限切れ','今日','明日',"3日以内"];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: deviceSize.width,
        height: double.infinity,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: GroupListView(
          sectionsCount: 4,
          countOfItemInSection: (int section) {
            if(section == 0){
              return cleaningList.overdueTasks.length;
            }else if(section == 1){
              return cleaningList.todayTasks.length;
            }else if(section == 2){
              return cleaningList.tomorrowTasks.length;
            }else{
              return cleaningList.threeDaysTasks.length;
            }

          },
          itemBuilder: (BuildContext context, IndexPath index) {
            List<Task> tasks = [];
            if(index.section == 0){
              tasks = cleaningList.overdueTasks;
            }else if(index.section == 1){
              tasks = cleaningList.todayTasks;
            }else if(index.section == 2){
              tasks = cleaningList.tomorrowTasks;
            }else{
              tasks = cleaningList.threeDaysTasks;
            }
            return Slidable(
              key: UniqueKey(),
              startActionPane: ActionPane(
                extentRatio: 0.3,
                motion: const StretchMotion(),
                dragDismissible: true,
                children: [
                  SlidableAction(
                    onPressed: (_) async {
                      final String? selectedText = await showDialog<String>(
                          context: context,
                          builder: (_) {
                            return ShowOperations(task: tasks[index.index],);
                          });
                    },
                    borderRadius: BorderRadius.circular(20),
                    backgroundColor: Colors.black12,
                    foregroundColor:Colors.black,
                    icon: Icons.redo_outlined,
                    label: "変更",
                  ),
                ],
              ),
              endActionPane: ActionPane(
                extentRatio: 0.5,
                motion: const StretchMotion(),
                dismissible: DismissiblePane(onDismissed: () {
                  cleaningListNotifier.updateTask(tasks[index.index]);
                }),
                children: [

                  SlidableAction(
                    onPressed: (_) {
                      cleaningListNotifier.updateTask(tasks[index.index]);
                    },
                    borderRadius: BorderRadius.circular(20),
                    backgroundColor: Colors.lightBlueAccent,
                    foregroundColor:Colors.black,
                    icon: Icons.check,
                    label: '完了',

                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: GestureDetector(
                  onLongPress: () async {
                    final String? selectedText = await showDialog<String>(
                        context: context,
                        builder: (_) {
                          return ShowOperations(task: tasks[index.index],);
                        });
                  },
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
                  ),
                ),
              ),
            );
          },
          groupHeaderBuilder: (BuildContext context, int section) {

            int itemCount = 0;
            if(section == 0){
              itemCount = cleaningList.overdueTasks.length;
            }else if(section == 1){
              itemCount = cleaningList.todayTasks.length;
            }else if(section == 2){
              itemCount = cleaningList.tomorrowTasks.length;
            }else{
              itemCount = cleaningList.threeDaysTasks.length;
            }
            return itemCount == 0 ? const SizedBox() : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Text(
                title[section],
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 5),
          sectionSeparatorBuilder: (context, section) => const SizedBox(height: 10),
        ),
      ),
    );
  }
}

class ShowOperations extends StatelessWidget {
  const ShowOperations({Key? key, required this.task}) : super(key: key);

  final Task task;
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.white.withOpacity(0.95),
      surfaceTintColor: Colors.transparent,

      title: Column(
        children: [
          Text(task.name,style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          const SizedBox(height: 5,),
          const Text("操作を選択して下さい",style: TextStyle(fontSize: 13,))
        ],
      ),
      children: [
        const Divider(),
        SimpleDialogOption(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: const Center(child: Text('今日へ移動')),
          onPressed: () {

          },
        ),
        const Divider(),
        SimpleDialogOption(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: const Center(child: Text('明日へ移動')),
          onPressed: () {

          },
        ),
        const Divider(),
        SimpleDialogOption(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: const Center(child: Text('3日以内へ移動')),
          onPressed: () {

          },
        ),
        const Divider(),
        SimpleDialogOption(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: const Center(child: Text('キャンセル', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),)),
          onPressed: () {

          },
        )
      ],
    );
  }
}