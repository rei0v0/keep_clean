import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
final svgProvider = StateProvider<int>((ref) => 0);
final pageProvider = StateProvider.autoDispose<PageController>((ref)=>PageController());
final indexProvider = StateProvider.autoDispose(<int>(ref) => 0);
final locationNameProvider = StateProvider.autoDispose<String>((ref) => '');


class AddLocationView extends ConsumerWidget{
  const AddLocationView({
    super.key,
  });

  @override
  Widget build(BuildContext context,WidgetRef ref) {


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
              const Text("新しい場所を追加"),
              const SizedBox(height: 20,),
              SizedBox(
                width: size.width * 0.7,
                height: 300,
                child: PageView(
                  controller: controller,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    SetNameView(),
                    SelectSvgView(),
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

              hintText: "キッチン",
            ),
            onChanged: (String text){
              ref.read(locationNameProvider.notifier).state = text;
            },
          ),
        ),
      ),
    );
  }
}
class SelectSvgView extends ConsumerWidget {

  const SelectSvgView({
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final int selectedSvg = ref.watch(svgProvider);
    final List<String> svgList = ["bathtub","bathtub2","bathtub3","bed","bed2","door","fork_spoon","hotpot","hotpot2","house","house2","house3","kitchen","toilet","toilet2","toilet3","washing_machine","washing_machine2","washing_machine3"];

    return Center(
      child: Wrap(
        spacing: 4.0,
        runSpacing: 4.0,
        children: List.generate(svgList.length, (index){
          return SizedBox(
            width: 50,
            height: 50,
            child: TextButton(
              onPressed: () {
                ref.read(svgProvider.notifier).state = index;
              },

              style: ElevatedButton.styleFrom(
                foregroundColor: const Color(0x9900ced1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: BorderSide(
                  color: index == selectedSvg ? const Color(0xff20b2aa) : Colors.grey,
                  width: 1,
                ),
              ),
              child: SvgPicture.asset(

                "asset/icon/${svgList[index]}.svg",
                width: 30,
                height: 25,
                colorFilter: ColorFilter.mode(index == selectedSvg ? const Color(0xff20b2aa) : Colors.grey, BlendMode.srcIn),
              ),
            ),
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
    final String locationName = ref.watch(locationNameProvider);
    final int selectedSvg = ref.watch(svgProvider);
    final List<String> svgList = ["bathtub","bathtub2","bathtub3","bed","bed2","door","fork_spoon","hotpot","hotpot2","house","house2","house3","kitchen","toilet","toilet2","toilet3","washing_machine","washing_machine2","washing_machine3"];


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
          onTap: locationName == "" ? null : (){
            int currentPage = controller.page!.round();
            if(currentPage == 0) {
              controller.nextPage(duration: const Duration(milliseconds: 500), curve: Curves.ease,);
              ref.read(indexProvider.notifier).state = 1;
            }else if(currentPage == 1){
              Navigator.pop(context,{"name": locationName, "iconName": svgList[selectedSvg]});
            }
          },
          child: Container(
            width: 120,
            height: 50,
            decoration: BoxDecoration(
                color: locationName == "" ? Colors.grey : Colors.black,
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
