import 'package:elementary/elementary.dart';
import 'package:endgame/assets/text/text.dart';
import 'package:endgame/features/detail_page/detail_page_wm.dart';
import 'package:endgame/utils/card_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

/// Экран деталей фото
class DetailScreen extends ElementaryWidget<IDetailWidgetModel> {
  final CardInfo cardInfo;

  DetailScreen({
    required this.cardInfo,
    Key? key,
  }) : super(placeDetailWidgetModelFactoryWithParams(cardInfo), key: key);

  @override
  Widget build(IDetailWidgetModel wm) {
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
          _PhotoWidget(
            photoUrl: cardInfo.imageUrl,
            hash: cardInfo.hash,
          ),
          _PhotoShortInfo(
            username: cardInfo.username,
            createdAt: cardInfo.createdAt,
            likes: cardInfo.likes,
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

class _PhotoWidget extends StatelessWidget {
  final String photoUrl;
  final String hash;

  const _PhotoWidget({required this.photoUrl, required this.hash, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            photoUrl,
            fit: BoxFit.fitWidth,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return BlurHash(hash: hash);
            },
          ),
        ],
      ),
    );
  }
}

class _PhotoShortInfo extends StatelessWidget {
  final String username;
  final String createdAt;
  final int likes;

  const _PhotoShortInfo(
      {required this.username,
      required this.createdAt,
      required this.likes,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                Text(
                  createdAt,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                ProjectStrings.getLikesString(likes),
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
