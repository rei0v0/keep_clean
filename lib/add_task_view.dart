import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cycleProvider = StateProvider.autoDispose<int>((ref) => 0);
final taskNameProvider = StateProvider.autoDispose<String>((ref) => '');
final pageProvider = StateProvider.autoDispose<PageController>((ref)=>PageController());
final indexProvider = StateProvider.autoDispose(<int>(ref) => 0);
final initialDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

class AddTaskView extends ConsumerWidget {

  const AddTaskView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    final controller = ref.watch(pageProvider);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        width: size.width,
        height: size.height * 0.9,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            const Text("新しいタスクを追加"),
            const SizedBox(height: 20,),
            SizedBox(
              width: size.width * 0.7,
              height: 300,
              child: PageView(
                controller: controller,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  SetNameView(),
                  SelectCycleView(),

                ],
              ),
            ),
            const SizedBox(height: 20,),
            const AddButton(),
          ],
        )
      ),
    );
  }

}

class SetNameView extends ConsumerWidget {
  const SetNameView({
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: Center(
        child: SizedBox(
          width: size.width * 0.5,
          child: TextField(
            autofocus: true,
            decoration: const InputDecoration(
              labelText: "掃除タイトル",
              hintText: "食器洗い",
            ),
            onChanged: (String text){
              ref.read(taskNameProvider.notifier).state = text;
            },
          ),
        ),
      ),
    );
  }
}

class SelectCycleView extends ConsumerWidget {

  const SelectCycleView({
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final int selectedCycle = ref.watch(cycleProvider);
    final List<String> cycles = ["毎日","２日に1回","3日に一回","週に1回","2週に1回","月に1回","毎週日曜","毎週月曜","毎週火曜","毎週水曜","毎週木曜","毎週金曜","毎週土曜"];
    final DateTime initialDate = ref.watch(initialDateProvider);
    final DateFormat outputFormat = DateFormat('yyyy/MM/dd');
    return Column(
      children: [
        TextButton(
          child: Text('初回の日付 : ${outputFormat.format(initialDate)}'),
          onPressed: () async {
            final today = DateTime.now();
            final DateTime? datePicked = await showDatePicker(
                context: context,
                initialDate: initialDate,
                firstDate: today,
                lastDate: today.add(const Duration(days: 30)));

            if(datePicked != null){
              ref.read(initialDateProvider.notifier).state = datePicked;
            }
          },
        ),
        Center(
          child: Wrap(
            spacing: 4.0,
            runSpacing: 0.0,
            children: List.generate(cycles.length, (index){
              return TextButton(
                onPressed: () async {
                  ref.read(cycleProvider.notifier).state = index;
                  if(index - 6 >= 0) {
                    ref.read(initialDateProvider.notifier).state = getNextWeekday(index - 6);
                  }else{
                    ref.read(initialDateProvider.notifier).state = DateTime.now();
                  }

                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color(0x9900ced1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  side: BorderSide(
                    color: index == selectedCycle ? const Color(0xff20b2aa) : Colors.grey,
                    width: 1,
                  ),
                ),
                child: Text(cycles[index],style: TextStyle(fontSize: 15, color: index == selectedCycle ? const Color(0xff20b2aa) : Colors.black)),
              );
            }),
          ),
        ),
      ],
    );
  }

  DateTime getNextWeekday(int weekday) {
    DateTime now = DateTime.now();
    int daysToAdd = (weekday - now.weekday + 7) % 7;
    DateTime nextWeekday = now.add(Duration(days: daysToAdd));
    return nextWeekday;
  }
}

class AddButton extends ConsumerWidget {
  const AddButton({
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(pageProvider);
    final pageIndex = ref.watch(indexProvider);
    final String taskName = ref.watch(taskNameProvider);
    final int selectedCycle = ref.watch(cycleProvider);
    final DateTime initialDate = ref.watch(initialDateProvider);
    final List<String> cyclesInEnglish = [
      "Daily", "Bi-daily", "Tri-daily", "Weekly", "Bi-weekly", "Monthly",
      "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if(pageIndex != 0)
          GestureDetector(
          onTap: (){
            int currentPage = controller.page!.round();
            if(currentPage == 1) {
              controller.animateToPage(0, duration: const Duration(milliseconds: 500), curve: Curves.ease);
              ref.read(indexProvider.notifier).state = 0;
            }
          },
          child: Container(
            width: 120,
            height: 50,
            decoration: const BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            child: const Center(
                child: Text(
                  "戻る",
                  style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                )
            ),
          ),
        ),
        if(pageIndex != 0)
          const SizedBox(width: 10,),
        GestureDetector(
          onTap: taskName == "" ? null : (){
            int currentPage = controller.page!.round();
            if(currentPage == 0) {
              controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease,);
              ref.read(indexProvider.notifier).state = 1;
            }else if(currentPage == 1){
              final due = DateTime(initialDate.year, initialDate.month, initialDate.day);
              Navigator.pop(context,{"name": taskName, "cycle": cyclesInEnglish[selectedCycle],"initialDate" : due});
            }
          },
          child: Container(
            width: 120,
            height: 50,
            decoration: BoxDecoration(
              color: taskName == "" ? Colors.grey : Colors.black,
              borderRadius: const BorderRadius.all(Radius.circular(20))
            ),
            child: Center(
                child: Text(
                  pageIndex == 0 ? "次へ" : "追加",
                  style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                )
            ),
          ),
        ),
      ],
    );
  }
}
