import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteappkimit/logic/login/cubit.dart';
import 'package:noteappkimit/presentation/screens/home_screen.dart';
import 'package:noteappkimit/presentation/screens/sign_up_screen.dart';
import 'package:noteappkimit/presentation/widgets/container_widget.dart';
import 'package:noteappkimit/presentation/widgets/text_form_field_widget.dart';
import 'package:noteappkimit/logic/login/state.dart';

import '../../core/const/txt.dart';
import '../../core/theme/colors.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({super.key});
  TextEditingController controllerloginemail = TextEditingController();
  TextEditingController controllerpasslogin = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginState>(
         
          listener: (context, state) {
            if (state is LoginLoadingState) {
               CircularProgressIndicator();
            } else if (state is LoginSuccessState) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            }
            else if(state is LoginErrorState){
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.em),
                  backgroundColor: Colors.red,
                ),
              );
              
            }
          },

          child: Scaffold(
            backgroundColor: ColorManager.primaryColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Center(
                    child: Text(
                      Txt.welcome,
                      style: TextStyle(
                        color: ColorManager.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
          
                  SizedBox(height: 16),
          
                  Text(
                    Txt.email,
                    style: TextStyle(
                      color: ColorManager.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextFormFieldWidget(
                    controller: controllerloginemail,
                    hintTxt: Txt.email,
                  ),
                  SizedBox(height: 16),
          
                  Text(
                    Txt.pass,
                    style: TextStyle(
                      color: ColorManager.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 6),
                  TextFormFieldWidget(
                    controller: controllerpasslogin,
                    hintTxt: Txt.passhint,
                  ),
                  SizedBox(height: 80),
          
                  Center(
                    child: InkWell(
                      onTap: (){
                        context.read<LoginCubit>().logIn(controllerloginemail.text, controllerpasslogin.text);
                      },
                      child: ContainerWidget(
                        buttonTxt: Txt.login,
                        buttonhight: 48,
                        buttonwidth: 312,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: ContainerWidget(
                      buttonTxt: Txt.continuewithgoogle,
                      buttonhight: 48,
                      buttonwidth: 312,
                    ),
                  ),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Text(
                        Txt.haveAcc,
                        style: TextStyle(
                          color: ColorManager.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));}, child: Text('Sing up'))
                    ],
                  ),
          
          
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
