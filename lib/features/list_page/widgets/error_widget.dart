import 'package:endgame/assets/colors/colors.dart';
import 'package:endgame/assets/text/text.dart';
import 'package:flutter/material.dart';

/// виджет при ошибке загрузки
class LoadingErrorWidget extends StatelessWidget {

  /// метод повторного загрузки фото
  final VoidCallback onPressed;

  const LoadingErrorWidget({required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 51,
      color: ProjectColors.errorColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Row(
          children: [
            const Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  ProjectStrings.error,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: onPressed,
                  child: const Text(
                    ProjectStrings.repeat,
                    style: TextStyle(
                      color: ProjectColors.black,
                      fontSize: 16,
                    ),
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
