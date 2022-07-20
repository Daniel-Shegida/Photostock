import 'package:endgame/assets/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';


/// карточки фото в листе
class ImageSheet extends StatelessWidget {

  /// метод перехода на экран деталей
  final VoidCallback onTap;

  /// CODEREVIEW
  /// 
  /// У тебя уже есть удобный класс CardInfo, в котором содержатся те же поля,
  /// так что в дублировании нет никакого смысла.
  
  ///  url фото
  final String imageUrl;
  ///  hash фото
  final String hash;
  ///  имя создавшего фото
  final String userName;
  ///  время создания фото
  final String createdAt;
  ///  кол-во лайков фото
  final int likes;

  const ImageSheet({
    required this.onTap,
    required this.imageUrl,
    required this.hash,
    required this.userName,
    required this.createdAt,
    required this.likes,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Container(
              height: 300,
              width: 300,
              decoration: const BoxDecoration(
                color: ProjectColors.black,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                ),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return BlurHash(hash: hash);
                  },
                ),
              ),
            ),
            SizedBox(
              width: 300,
              child: Container(
                decoration: const BoxDecoration(
                  color: ProjectColors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40.0),
                    bottomLeft: Radius.circular(40.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 8, bottom: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName,
                              style: const TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              createdAt,
                              style: const TextStyle(
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Center(
                        child: Text(
                          "$likes likes",
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
