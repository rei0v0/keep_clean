import 'package:flutter/material.dart';
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

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.tealAccent),
        useMaterial3: true,
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

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.white,
          title: const Text("Keep Clean"),
      ),
      body: pages[pageIndex],


      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.blue,
        onDestinationSelected: (int index){
          ref.read(pageIndexProvider.notifier).state = index;
        },
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(Icons.mail),
            icon: Icon(Icons.mail_outline),
            label: 'First',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.egg),
            icon: Icon(Icons.egg_outlined),
            label: 'Second',
          ),
        ],

      ),
    );
  }


}
