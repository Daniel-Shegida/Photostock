import 'package:elementary/elementary.dart';
import 'package:endgame/features/detail_page/detail_page_model.dart';
import 'package:endgame/features/detail_page/detail_page_screen.dart';
import 'package:endgame/utils/card_info.dart';
import 'package:flutter/material.dart';

DetailWidgetModel Function(BuildContext context)
    placeDetailWidgetModelFactoryWithParams(CardInfo url) {
  return (context) {
    return DetailWidgetModel(
      url,
      DetailModel(),
    );
  };
}

class DetailWidgetModel extends WidgetModel<DetailScreen, DetailModel>
    with SingleTickerProviderWidgetModelMixin
    implements IDetailWidgetModel {
  DetailWidgetModel(
    this._cardInfo,
    DetailModel model,
  ) : super(model);

  final CardInfo _cardInfo;

  @override
  CardInfo get cardInfo => _cardInfo;

  /// CODEREVIEW
  ///
  /// Старайся избегать лишних оверрайдов, они только засоряют код.
  @override
  void initWidgetModel() {
    super.initWidgetModel();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// CODEREVIEW
  ///
  /// Несущественный момент. Поскольку виджет модель - представление экрана,
  /// гораздо логичнее называть методы в ней действиями пользователя
  /// (напр. onBackButtonPressed), а не конечным действием (pop).
  ///
  /// Таким образом, твоя WM становится отражением всего, что происходит на
  /// экране.
  @override
  void pop() {
    Navigator.pop(context);
  }
}

/// CODEREVIEW
///
/// Использовать интерфейсы для WM - хорошая практика, уважаю.

/// Interface of [DetailWidgetModel].
abstract class IDetailWidgetModel extends IWidgetModel {
  /// CODEERVIEW
  ///
  /// В итоге получаем, что у тебя есть cardInfo в WM, но ты её не используешь.

  /// Информация о фото
  CardInfo get cardInfo;

  /// переход обратно на экран списка фото
  void pop();
}
