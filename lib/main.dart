import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keep_clean/clening_list_page.dart';
import 'package:keep_clean/db/cleaningDB.dart';
import 'package:keep_clean/model/location.dart';
import 'package:keep_clean/setting_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

  if (isFirstLaunch) {
    await registerLocationsToDatabase();
    await prefs.setBool('isFirstLaunch', false);
  }
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

Future<void> registerLocationsToDatabase() async{
  final cleaningDatabase = CleaningDatabase.instance;
  final locationNames = {"リビング":"house","キッチン":"kitchen","浴室":"bathtub","トイレ":"toilet","玄関":"door"};

  final List<Location> locations = locationNames.entries.map((entry) {
    return Location(name: entry.key, iconName: entry.value);
  }).toList();

  for (var location in locations){
    await cleaningDatabase.insertLocation(location);
  }
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
        fontFamily: "Noto Sans JP",
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
    final pages = [const CleaningListPage(), const SettingPage()];
    
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
        centerTitle: false,
        title: Row(
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: SvgPicture.asset(
                "asset/KeepCleanIcon.svg",
              ),
            ),
            const SizedBox(width: 10,),
            const Text("Keep Clean",style: TextStyle(color: Colors.black, fontSize: 22,fontFamily: "AbrilFatface"),)
          ],
        ),
      ),
      body: pages[pageIndex],


      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration:  const BoxDecoration(
          color: Colors.white,
          borderRadius:  BorderRadius.only(
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
          shadowColor: Colors.lightBlueAccent,
          selectedIndex: pageIndex,
          elevation: 0.0,
          indicatorColor: Colors.transparent,
          onDestinationSelected: (int index){
            ref.read(pageIndexProvider.notifier).state = index;
          },
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.view_list, color: Colors.lightBlueAccent,),
              icon: Icon(Icons.view_list_sharp, color: Colors.grey,),
              label: '掃除リスト',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.assignment, color: Colors.lightBlueAccent,),
              icon: Icon(Icons.assignment_outlined, color:Colors.grey,),
              label: '掃除設定',
            ),
          ],

        ),
      ),
    );
  }


}
