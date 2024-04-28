// ignore_for_file: prefer_const_constructors_in_immutables, prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'package:elctric_ecommerce/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ExpandedTextWidget extends StatefulWidget {
  ExpandedTextWidget({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  State<ExpandedTextWidget> createState() => _ExpandedTextWidgetState();
}

class _ExpandedTextWidgetState extends State<ExpandedTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;

  double textHeight = Get.height / 5.85;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: secondHalf.isEmpty
            ? Text(
                firstHalf,
              )
            : Column(
                children: [
                  Text(
                    hiddenText ? (firstHalf + "...") : (firstHalf + secondHalf),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        hiddenText = !hiddenText;
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          hiddenText ? "show more" : "Less more",
                          style: TextStyle(
                            color: TColors.primaryColor,
                          ),
                        ),
                        Icon(
                          hiddenText
                              ? Icons.arrow_drop_down
                              : Icons.arrow_drop_up,
                          color: TColors.primaryColor,
                        )
                      ],
                    ),
                  )
                ],
              ));
  }
}
