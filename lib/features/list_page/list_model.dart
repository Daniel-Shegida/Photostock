


import 'package:elementary/elementary.dart';

/// Модель экрана мест
class ListPageModel extends ElementaryModel {

  // /// Подписка на блок.
  // Stream<BasePlaceState> get placeStateStream => _placeBloc.stream;
  //
  // /// Получает стейт из блока.
  // BasePlaceState get currentState => _placeBloc.state;

  /// Конструктор [ListPageModel].
  ListPageModel(
      ) : super();

  /// закрытие потоков
  @override
  void dispose() {
    super.dispose();
  }

  /// получить список мест с параметрами поиска
  void search(List<String> searchingTypeList, String search) {
  }
}