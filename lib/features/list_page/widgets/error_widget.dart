import 'package:flutter/material.dart';

class ErrorWidget2 extends StatelessWidget {
  final VoidCallback onPressed;
  const ErrorWidget2({required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 51,
      color: Colors.deepOrangeAccent,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 16,),
        child: Row(
          children: [
            Expanded(
              child: Align(
                  alignment: Alignment.centerLeft,
                  child:  Text(
                    "Ошибка загрузки",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                // child: TextButton(
                //   style: TextButton.styleFrom(
                //     primary: Colors.black87,
                //     textStyle: TextStyle(
                //       color: Colors.black87,
                //       fontSize: 16,
                //     ),
                //   ),
                //   onPressed: onPressed,
                  child:  InkWell(
                    onTap: onPressed,
                    child: Text(
                    'Повторить',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                    ),
                ),
                  ),
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
