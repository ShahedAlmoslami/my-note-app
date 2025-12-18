import 'package:flutter/material.dart';

import '../../core/theme/colors.dart';

class TextFormFieldWidget extends StatefulWidget {
  final String hintTxt;
  final TextEditingController controller;

   TextFormFieldWidget({super.key,required this.controller,required this.hintTxt});

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: TextFormField(
        controller: widget.controller,
        style: TextStyle(
          color: ColorManager.white,

        ),
        decoration: InputDecoration(
          fillColor: ColorManager.txtFeildColor,
          filled: true,
          border: InputBorder.none,
          hintText:widget.hintTxt,


        ),
      ),
    );

  }
}
