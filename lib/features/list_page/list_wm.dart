import 'dart:convert';

import 'package:elementary/elementary.dart';
import 'package:endgame/features/detail_page/detail_page_screen.dart';
import 'package:endgame/features/list_page/list_model.dart';
import 'package:endgame/features/list_page/list_page.dart';
import 'package:endgame/features/utils/card_info.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer';

const int IMAGES_PER_PAGE = 3;

/// Factory for [ListPageWidgetModel]
ListPageWidgetModel listPageWidgetModelFactory(BuildContext context) {
  return ListPageWidgetModel(
    ListPageModel(),
  );
}

/// WidgetModel for [ListPageScreen]
class ListPageWidgetModel extends WidgetModel<ListPageScreen, ListPageModel>
    with SingleTickerProviderWidgetModelMixin
    implements IListPageWidgetModel {
  final _scrollController = ScrollController();

  final _scrollController2 = ScrollController();

  int _currentPage = 1;

  final List<String> _searchParams = [];

  // final StateNotifier<PlaceFiltersList> _checkBoxNotifier =
  // StateNotifier<PlaceFiltersList>();

  @override
  ScrollController get scrollController => _scrollController;

  @override
  ScrollController get scrollController2 => _scrollController2;

  //
  // @override
  // ListenableState<EntityState<List<Place>>> get placesListState =>
  //     _placesListState;

  // late StreamSubscription _blocSubscription;

  EntityStateNotifier<List<CardInfo>> _test =
      EntityStateNotifier<List<CardInfo>>();

  EntityStateNotifier<bool> _test2 =
  EntityStateNotifier<bool>();

  /// standard consctructor for elem
  ListPageWidgetModel(
    ListPageModel model,
    // this._navigationHelper,
  ) : super(model);

  @override
  // TODO: implement placesListState
  ListenableState<EntityState<List<CardInfo>>> get placesListState => _test;

  @override
  ListenableState<EntityState<bool>> get placesListState2 => _test2;

  bool loading = false;

  @override
  void initWidgetModel() {
    // _test.error();
    _test.loading();
    loading = true;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent
          // && !loading
          ) {
        _test2.loading();
        // getApiData();
      }
    });

    try {
      getApiData();
    } catch (e) {
      _test.error();
    }
    super.initWidgetModel();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void push(CardInfo cardInfo) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            //     ImageView(
            //   url: string,
            // ),
            PlaceDetailScreen(
          cardInfo: cardInfo,
        ),
      ),
    );
  }

  @override
  void getApiData() async {
    try {
      var url = Uri.parse(
          "https://api.unsplash.com/photos/?per_page=$IMAGES_PER_PAGE&page=$_currentPage&client_id=896d4f52c589547b2134bd75ed48742db637fa51810b49b607e37e46ab2c0043");
      final res = await http.get(url).timeout(Duration(seconds: 3));
      print(res);
      final body = jsonDecode(res.body);
      // print(body);
      // print('url');
      // log(body.toString());

      // print(body);
      // debugPrint(body, wrapWidth: 1024);
      // print(body[0]['urls']['full'].runtimeType);
      // print(body[1]['urls']['full']);
      // print(body[1]['urls']['full'].runtimeType);
      // print(body[1]['likes']);
      // print(body[1]['likes'].runtimeType);
      // print(body[1]['created_at']);
      // print(body[1]['created_at'].runtimeType);
      // print(DateTime.parse(body[1]['created_at']));
      // print(DateTime.parse(body[1]['created_at']).runtimeType);
      // print("${test.day}.${test.month}.${test.year}");
      DateTime data0 = DateTime.parse(body[0]['created_at']);
      DateTime data1 = DateTime.parse(body[1]['created_at']);
      DateTime data2 = DateTime.parse(body[2]['created_at']);
      List<CardInfo> test4 = [
        CardInfo(
          imageUrl: body[0]['urls']['full'],
          hash: body[0]['blur_hash'] ?? 'LrGS16e-Rjax~qRjWBj[-=azoLay',
          username: body[0]['user']['username'] ?? "nobody",
          likes: body[0]['likes'] ?? 0,
          description: body[0]['description'] ?? "no desc",
          createdAt: "${data0.day}.${data0.month}.${data0.year}",
        ),
        CardInfo(
          imageUrl: body[1]['urls']['full'],
          hash: body[1]['blur_hash'] ?? 'LrGS16e-Rjax~qRjWBj[-=azoLay',
          username: body[1]['user']['username'] ?? "nobody",
          likes: body[1]['likes'] ?? 0,
          description: body[1]['description'] ?? "no desc",
          createdAt: '${data1.day}.${data1.month}.${data1.year}',
        ),
        CardInfo(
          imageUrl: body[2]['urls']['full'],
          hash: body[2]['blur_hash'] ?? 'LrGS16e-Rjax~qRjWBj[-=azoLay',
          username: body[2]['user']['username'] ?? "nobody",
          likes: body[2]['likes'] ?? 0,
          description: body[2]['description'] ?? "no desc",
          createdAt: '${data2.day}.${data2.month}.${data2.year}',
        ),
      ];

      List<CardInfo> test5 = _test.value?.data ?? [];

      test5.addAll(test4);

      _test.content(test5);
      _currentPage++;
      loading = true;
    } catch (e) {
      if (_test.value?.data?.isEmpty ?? true) {
        _test.error();
      } else {
      }
    }
  }
}

/// Interface of [ListPageWidgetModel].
abstract class IListPageWidgetModel extends IWidgetModel {
  /// Text editing controller Main Screen.
  ScrollController get scrollController;

  ScrollController get scrollController2;


  /// показываемые темы
  ListenableState<EntityState<List<CardInfo>>> get placesListState;

  /// показываемые темы
  ListenableState<EntityState<bool>> get placesListState2;

  /// action of dialog
  void getApiData();

  /// action of dialog
  void push(CardInfo cardInfo);
}
