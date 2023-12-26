import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keep_clean/model/cleaning_list_page_state.dart';


final cleaningListProvider = StateNotifierProvider<CleaningListNotifier, CleaningListPageState>((ref) {
  return CleaningListNotifier();
});

class CleaningListNotifier extends StateNotifier<CleaningListPageState> {


  final ScrollController scrollController = ScrollController();
  final double currentPosition = 0.0;
  double topContainer = 0.0;

  CleaningListNotifier() : super(const CleaningListPageState()) {
    _initScrollController();
  }


  void _initScrollController() {
    scrollController.addListener(_scrollListener);
  }
  void _scrollListener() {

    double value = scrollController.offset/100;
    print("offset");
    print(scrollController.offset);
    print(value);
    double positionRate =
        scrollController.offset / scrollController.position.maxScrollExtent;
    state = state.copyWith(topContainer: value, position: positionRate);

  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

}