import 'package:flutter/cupertino.dart';

const EdgeInsetsGeometry kDefaultPadding = EdgeInsets.all(15);

Widget verticalSpace({double value = 10}) => SizedBox(
      height: value,
    );
Widget horizontalSpace({double value = 10}) => SizedBox(
      width: value,
    );
