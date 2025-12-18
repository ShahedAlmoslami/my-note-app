import 'package:flutter/material.dart';
import 'package:noteappkimit/presentation/widgets/text_form_field_widget.dart';
import '../../core/const/txt.dart';
import '../../core/theme/colors.dart';

class SignUpScreen extends StatelessWidget {
   SignUpScreen({super.key});
  TextEditingController passController=TextEditingController();
   TextEditingController emailController=TextEditingController();


   @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.primaryColor,
        body:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40,),

              Center(
                child: Text(Txt.createAcc,
                style: TextStyle(
                  color: ColorManager.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,

                ),),
              ),
              SizedBox(height: 16,),

              Text(Txt.email,style: TextStyle(
                color: ColorManager.white,
                fontSize: 24,
                fontWeight: FontWeight.w700
              ),),
              TextFormFieldWidget(controller: emailController, hintTxt: Txt.emailHint),
              SizedBox(height: 16,),

              Text(Txt.pass,style: TextStyle(
                  color: ColorManager.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700
              ),),
              TextFormFieldWidget(controller: passController, hintTxt: Txt.passhint),
              SizedBox(height: 80,),
             Spacer(),
             Center(
               child: Container(
                 height:48 ,
                 width: 318,
                 decoration: BoxDecoration(
                   color: ColorManager.white,
                   borderRadius: BorderRadius.circular(10)
                 ),
                 child:
                 Center(
                   child: Text(Txt.signUpTxt,
                     style: TextStyle(
                       fontWeight: FontWeight.w700,
                       fontSize: 16,
                       color:ColorManager.signUpColor,
               
                     ),
                   ),
                 ),
               
               ),
             ),
              SizedBox(height: 400,)

            ],
          ),
        ),
      ),
    );
  }
}
