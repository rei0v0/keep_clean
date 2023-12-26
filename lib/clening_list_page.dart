import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keep_clean/notifier/cleaning_list_notifier.dart';
import 'package:group_list_view/group_list_view.dart';

class CleaningListPage extends ConsumerWidget {

  const CleaningListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = [0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0,11.0,12.0,13.0,14.0,15.0,16.0,17.0];
    final deviceSize = MediaQuery.of(context).size;
    final cleaningListNotifier = ref.read(cleaningListProvider.notifier);
    final pageState = ref.watch(cleaningListProvider);
    Map<String, List> _elements = {
      'Team A': ['Klay Lewis', 'Ehsan Woodard', 'River Bains'],
      'Team B': ['Toyah Downs', 'Tyla Kane'],
    };
    return Scaffold(
      body: Container(
        width: deviceSize.width,
        height: double.infinity,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          children: [

            Expanded(
              child: GroupListView(
                sectionsCount: _elements.keys.toList().length,
                countOfItemInSection: (int section) {
                  return _elements.values.toList()[section].length;
                },
                itemBuilder: (BuildContext context, IndexPath index) {
                  return Container(
                    height: 80,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey, //色
                          spreadRadius: 1,
                          blurRadius: 1,
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
                                  color: Colors.greenAccent,
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
                                _elements.values.toList()[index.section][index.index],
                                style: TextStyle(color: Colors.black, fontSize: 15),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(width: 50,),
                            Text("ここに説明を記載する。",style: TextStyle(color: Colors.black, fontSize: 13),)
                          ],
                        ),
                      ],
                    ),
                  );
                },
                groupHeaderBuilder: (BuildContext context, int section) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Text(
                      _elements.keys.toList()[section].toString(),
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 10),
                sectionSeparatorBuilder: (context, section) => SizedBox(height: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
  double calculateHeightFactor(int index, double scrollPosition, int itemCount) {
    // アイテムがスクロールビューのどの位置にあるかを計算
    double positionThreshold = (itemCount - index) / itemCount;

    return positionThreshold;

    // スクロール位置とアイテムの位置に基づいて heightFactor を計算
    // 例えば、スクロールがアイテムを過ぎると、heightFactor が 1.0 から 0.5 に減少する
    if (scrollPosition >= positionThreshold + 0.2) {
      double factor = 1.0 - (scrollPosition - positionThreshold) * 2; // 2倍することで、変化を強調
      return factor.clamp(0.1, 1.0); // 0.5から1.0の間に制限
    } else {
      return 1.0;
    }
  }
}