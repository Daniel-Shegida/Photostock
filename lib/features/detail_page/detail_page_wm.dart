import 'package:elementary/elementary.dart';
import 'package:endgame/features/detail_page/detail_page_model.dart';
import 'package:endgame/features/detail_page/detail_page_screen.dart';
import 'package:endgame/features/utils/card_info.dart';
import 'package:flutter/material.dart';

/// фабрика создания [PlaceDetailWidgetModel]
PlaceDetailWidgetModel Function(BuildContext context)
placeDetailWidgetModelFactoryWithParams(CardInfo _url) {
  return (context) {
    return PlaceDetailWidgetModel(
      _url,
      PlaceDetailModel(
      ),
    );
  };
}

/// WidgetModel for [PlaceDetailScreen]
class PlaceDetailWidgetModel
    extends WidgetModel<PlaceDetailScreen, PlaceDetailModel>
    with SingleTickerProviderWidgetModelMixin
    implements IPlaceDetailWidgetModel {


  /// standard consctructor for elem
  PlaceDetailWidgetModel(
      CardInfo this._url,
      PlaceDetailModel model,
      ) : super(model);

  final CardInfo _url;

  CardInfo get url => _url;

  @override
  void initWidgetModel() {

    super.initWidgetModel();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void pop() {
    Navigator.pop(context);
  }
}

/// Interface of [PlaceDetailWidgetModel].
abstract class IPlaceDetailWidgetModel extends IWidgetModel {

  CardInfo get url;
  void pop();

}