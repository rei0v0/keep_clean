import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cycleProvider = StateProvider<int>((ref) => 0);
final taskNameProvider = StateProvider.autoDispose<String>((ref) => '');
final pageProvider = StateProvider.autoDispose<PageController>((ref)=>PageController());
final indexProvider = StateProvider.autoDispose(<int>(ref) => 0);

class AddTaskView extends ConsumerWidget {

  const AddTaskView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Size size = MediaQuery.of(context).size;
    final controller = ref.watch(pageProvider);
    final String taskName = ref.watch(taskNameProvider);

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
                  SelectCycleView(),
                  SetNameView(),
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

    return Center(
      child: Wrap(
        spacing: 4.0,
        runSpacing: 0.0,
        children: List.generate(cycles.length, (index){
          return TextButton(
            onPressed: () {
              ref.read(cycleProvider.notifier).state = index;
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
    );
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
          onTap: (){
            int currentPage = controller.page!.round();
            if(currentPage == 0) {
              controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease,);
              ref.read(indexProvider.notifier).state = 1;
            }else if(currentPage == 1){

            }
          },
          child: Container(
            width: 120,
            height: 50,
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(20))
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
