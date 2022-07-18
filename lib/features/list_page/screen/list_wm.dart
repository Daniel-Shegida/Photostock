import 'package:elementary/elementary.dart';
import 'package:endgame/features/detail_page/detail_page_screen.dart';
import 'package:endgame/features/list_page/screen/list_model.dart';
import 'package:endgame/features/list_page/screen/list_page.dart';
import 'package:endgame/utils/card_info.dart';
import 'package:flutter/material.dart';

ListPageWidgetModel listPageWidgetModelFactory(BuildContext context) {
  return ListPageWidgetModel(
    ListPageModel(),
  );
}

class ListPageWidgetModel extends WidgetModel<ListPageScreen, ListPageModel>
    with SingleTickerProviderWidgetModelMixin
    implements IListPageWidgetModel {
  final _scrollController = ScrollController();

  int _currentPage = 1;

  final EntityStateNotifier<List<CardInfo>> _photoListState =
      EntityStateNotifier<List<CardInfo>>();

  final EntityStateNotifier<bool> _loadingState = EntityStateNotifier<bool>();

  ListPageWidgetModel(
    ListPageModel model,
  ) : super(model);

  bool loading = false;
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
  ListenableState<EntityState<List<CardInfo>>> get photoListState =>
      _photoListState;

  @override
  ListenableState<EntityState<bool>> get loadingState => _loadingState;

  @override
  ScrollController get scrollController => _scrollController;

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
  /// Скролл контролеер отвечающий за пагинациб
  ScrollController get scrollController;

  /// показываемые фото
  ListenableState<EntityState<List<CardInfo>>> get photoListState;

  /// показываемый лоудер или ошибка
  ListenableState<EntityState<bool>> get loadingState;

  /// метод для загрузки при первой неудачи
  void startingLoad();

  /// метод для загрузки при не первой неудачи
  void errorLoad();

  ///  переход на экран деталей
  void pushToDetailScreen(CardInfo cardInfo);
}
