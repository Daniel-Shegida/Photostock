import 'package:elementary/elementary.dart';
import 'package:endgame/features/list_page/list_wm.dart';
import 'package:endgame/features/list_page/widgets/Image_sheet.dart';
import 'package:endgame/features/list_page/widgets/error_widget.dart';
import 'package:endgame/features/utils/card_info.dart';
import 'package:flutter/material.dart';

/// экран просмотра существующих мест
class ListPageScreen extends ElementaryWidget<IListPageWidgetModel> {
  /// standard consctructor for elem
  const ListPageScreen({
    Key? key,
    WidgetModelFactory wmFactory = listPageWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IListPageWidgetModel wm) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: EntityStateNotifierBuilder<List<CardInfo>>(
        listenableEntityState: wm.placesListState,
        builder: (_, value) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.5),
            child: Stack(
              children: [
                LayoutBuilder(
                  builder: (context, viewportConstraints) {
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            controller: wm.scrollController,
                            itemBuilder: (context, index) {
                              return ImageSheet(
                                imageUrl: value?[index].imageUrl ?? "daq",
                                onTap: () {
                                  print(value?[1]);
                                  wm.push(value![index]);
                                  // wm.getApiData;
                                },
                                userName: value?[index].username ?? '',
                                hash: value?[index].hash ?? "",
                                likes: value?[index].likes ?? 0,
                                createdAt: value?[index].createdAt ?? "",
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 20,
                              );
                            },
                            itemCount: value?.length ?? 0,
                          ),
                        ),
                        EntityStateNotifierBuilder<bool>(
                          listenableEntityState: wm.placesListState2,
                          builder: (_, value) {
                            return const SizedBox.shrink();
                          },
                          errorBuilder: (_, __, ___) {
                            return ErrorWidget2(onPressed: wm.getApiData);
                          },
                          loadingBuilder: (_, __) {
                            return const CircularProgressIndicator();
                          },
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
        loadingBuilder: (_, value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        errorBuilder: (
          ____,
          __,
          ___,
        ) {
          return Center(
            child: ErrorWidget2(
              onPressed: wm.getApiData,
            ),
          );
        },
      ),
    );
  }
}
