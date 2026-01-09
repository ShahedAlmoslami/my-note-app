import 'package:flutter/material.dart';

import '../../core/theme/colors.dart';

class ContainerWidget extends StatefulWidget {
  String buttonTxt;
  double buttonhight =48;
  double buttonwidth =318;


   ContainerWidget({super.key,required this.buttonTxt, required this.buttonhight,required this.buttonwidth});


  @override
  State<ContainerWidget> createState() => _ContainerWidgetState();
}

class _ContainerWidgetState extends State<ContainerWidget> {
  
  @override
  Widget build(BuildContext context) {
    return  Container(
    height:widget.buttonhight ,
    width: widget.buttonwidth,
    decoration: BoxDecoration(
    color: ColorManager.white,
    borderRadius: BorderRadius.circular(10)
    ),
    child:
    Center(
    child: Text(widget.buttonTxt,
    style: TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 16,
    color:ColorManager.signUpColor, 
    
    ),
    ),
    ),
    
    );

  }
}
