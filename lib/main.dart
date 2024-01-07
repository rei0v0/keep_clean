import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keep_clean/clening_list_page.dart';

void main() {

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}


final pageIndexProvider = StateProvider((ref) {return 0;});

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keep Clean',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: false,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerWidget {

  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.watch(pageIndexProvider);
    final pages = [const CleaningListPage(), Center(child: Text("second page"),)];
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,     // for iOS
          statusBarIconBrightness: Brightness.dark,  // for Android
          statusBarColor: Colors.white,
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        title: const Text("Keep Clean",style: TextStyle(color: Colors.black),),
      ),
      body: pages[pageIndex],


      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration:  BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: NavigationBar(
          height: 70,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.greenAccent,
          selectedIndex: pageIndex,
          elevation: 0.0,
          indicatorColor: Colors.transparent,
          onDestinationSelected: (int index){
            ref.read(pageIndexProvider.notifier).state = index;
          },
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.view_list, color: Colors.greenAccent,),
              icon: Icon(Icons.view_list_sharp, color: Colors.grey,),
              label: '掃除リスト',
            ),
            NavigationDestination(

              selectedIcon: Icon(Icons.assignment, color: Colors.greenAccent,),
              icon: Icon(Icons.assignment_outlined, color:Colors.grey,),
              label: '設定',
            ),
          ],

        ),
      ),
    );
  }


}
