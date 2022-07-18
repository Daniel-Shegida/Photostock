import 'package:elementary/elementary.dart';
import 'package:endgame/features/detail_page/detail_page_screen.dart';
import 'package:endgame/features/list_page/screen/list_model.dart';
import 'package:endgame/features/list_page/screen/list_page.dart';
import 'package:endgame/features/utils/card_info.dart';
import 'package:flutter/material.dart';

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

  int _currentPage = 1;

  @override
  ScrollController get scrollController => _scrollController;

  final EntityStateNotifier<List<CardInfo>> _photoListState =
      EntityStateNotifier<List<CardInfo>>();

  final EntityStateNotifier<bool> _loadingState = EntityStateNotifier<bool>();

  /// standard consctructor for elem
  ListPageWidgetModel(
    ListPageModel model,
  ) : super(model);

  @override
  ListenableState<EntityState<List<CardInfo>>> get photoListState =>
      _photoListState;

  @override
  ListenableState<EntityState<bool>> get loadingState => _loadingState;

  bool loading = false;

  @override
  void initWidgetModel() {
    _photoListState.loading();
    loading = true;
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          !loading) {
        loading = true;
        _loadingState.loading();
        _getApiData();
      }
    });
    _getApiData();

    super.initWidgetModel();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void pushToDetailScreen(CardInfo cardInfo) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          cardInfo: cardInfo,
        ),
      ),
    );
  }

  void _getApiData() async {
    final newCardList = await model.search(_currentPage);

    if (newCardList == null) {
      if (_photoListState.value?.data?.isEmpty ?? true) {
        _photoListState.error();
      } else {
        _loadingState.error();
      }
    } else {
      List<CardInfo> oldCardList = _photoListState.value?.data ?? [];

      oldCardList.addAll(newCardList);

      _photoListState.content(oldCardList);
      _currentPage++;
      loading = false;
      _loadingState.content(true);
    }
  }

  @override
  void errorLoad() {
    _loadingState.loading();
    _getApiData();
  }

  @override
  void startingLoad() {
    _photoListState.loading();
    _getApiData();
  }
}

/// Interface of [ListPageWidgetModel].
abstract class IListPageWidgetModel extends IWidgetModel {
  /// Text editing controller Main Screen.
  ScrollController get scrollController;

  /// показываемые темы
  ListenableState<EntityState<List<CardInfo>>> get photoListState;

  /// показываемые темы
  ListenableState<EntityState<bool>> get loadingState;

  /// action of dialog
  void startingLoad();

  /// action of dialog
  void errorLoad();

  /// action of dialog
  void pushToDetailScreen(CardInfo cardInfo);
}
