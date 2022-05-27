import 'package:flutter/material.dart';

class ImgAvatar extends StatelessWidget {
  final String txt;
  const ImgAvatar({Key? key, required this.txt}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (txt.compareTo('0') == 0) {
      return const Image(image: AssetImage('assets/images/placeholder.png'));
    }

    return Image.network(txt, fit: BoxFit.fitHeight);
  }
}

