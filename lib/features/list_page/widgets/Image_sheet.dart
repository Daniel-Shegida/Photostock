import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class ImageSheet extends StatelessWidget {
  final VoidCallback onTap;
  final String imageUrl;
  final String hash;
  final String userName;
  final String createdAt;
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
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),

                  // border: Border.symmetric(horizontal: ),
                ),
              ),
              // child: Hero(
              //   tag: 'full2',
              child: Container(
                // color: Colors.red,
                decoration: BoxDecoration(
                  // image: DecorationImage(
                  //     image: NetworkImage(imageUrl, ), fit: BoxFit.cover),
                  color: Colors.black,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    topLeft: Radius.circular(40.0),

                    // border: Border.symmetric(horizontal: ),
                  ),
                ),
                // color: Colors.red,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(40.0),
                    topLeft: Radius.circular(40.0),

                    // border: Border.symmetric(horizontal: ),
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
              // ),
            ),
            SizedBox(
              // height: 100,
              width: 300,
              // color: Colors.white,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40.0),
                    bottomLeft: Radius.circular(40.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 8, bottom: 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              createdAt,
                              style: TextStyle(
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
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      )
                      // Expanded(
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: const [
                      //       Text("adaq"),
                      //
                      //     ],
                      //   ),
                      // ),
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
