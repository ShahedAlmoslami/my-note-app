import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteappkimit/logic/sign_up/cubit.dart';
import 'package:noteappkimit/logic/sign_up/state.dart';
import 'package:noteappkimit/presentation/screens/log_in_screen.dart';
import 'package:noteappkimit/presentation/widgets/text_form_field_widget.dart';
import '../../core/const/txt.dart';
import '../../core/theme/colors.dart';


class SignUpScreen extends StatelessWidget {
   SignUpScreen({super.key});
  final TextEditingController passController = TextEditingController();
  final TextEditingController emailController = TextEditingController();


  @override
  Widget build(BuildContext context) {
  
    return SafeArea(
      child: BlocProvider(
        create: (context) => SignUpCubit(),
        child: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            
            
            if (state is SignUpSuccessState) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LogInScreen()));
            }
            else if(state is SignUpErrorState){
              final snackBar = SnackBar(
                content: Text(state.em),
                backgroundColor: Colors.red,
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
          builder: (context, state) {
            final isLoading = state is SignUpLoadingState;
            return Scaffold(
              backgroundColor: ColorManager.primaryColor,
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),

                    Center(
                      child: Text(
                        Txt.createAcc,
                        style: const TextStyle(
                          color: ColorManager.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    Text(
                      Txt.email,
                      style: const TextStyle(
                        color: ColorManager.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextFormFieldWidget(controller: emailController, hintTxt: Txt.emailHint),
                    const SizedBox(height: 16),

                    Text(
                      Txt.pass,
                      style: const TextStyle(
                        color: ColorManager.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextFormFieldWidget(controller: passController, hintTxt: Txt.passhint),
                    const SizedBox(height: 80),
                    const Spacer(),
                    Center(
                      child: InkWell(
                        onTap: (){
                          context.read<SignUpCubit>().SignUp(emailController.text, passController.text)   ;                      },
                        child: Container(
                          height: 48,
                          width: 318,
                          decoration: BoxDecoration(
                            color: ColorManager.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  )
                                : Text(
                                    Txt.signUpTxt,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16,
                                      color: ColorManager.signUpColor,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 400),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
