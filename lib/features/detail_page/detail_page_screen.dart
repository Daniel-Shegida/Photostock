import 'package:elementary/elementary.dart';
import 'package:endgame/features/detail_page/detail_page_wm.dart';
import 'package:endgame/features/utils/card_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

/// экран добавления места
class PlaceDetailScreen extends ElementaryWidget<IPlaceDetailWidgetModel> {
  final CardInfo cardInfo;

  /// standard consctructor for elem
  PlaceDetailScreen({
    required this.cardInfo,
    Key? key,
  }) : super(placeDetailWidgetModelFactoryWithParams(cardInfo), key: key);

  @override
  Widget build(IPlaceDetailWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
        icon: const Icon(
          Icons.keyboard_arrow_left,
        ),
        onPressed: wm.pop,
      )),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  cardInfo.imageUrl,
                  fit: BoxFit.fitWidth,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return BlurHash(hash: cardInfo.hash);
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cardInfo.username,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        cardInfo.createdAt,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  // child: Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${cardInfo.likes} likes',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  //   ],
                  // ),
                ),
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.topLeft,
              child: Text(cardInfo.description))
        ],
      ),
    );
  }
}
