import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteappkimit/core/theme/colors.dart';
import 'package:noteappkimit/logic/home/state.dart';
import 'package:noteappkimit/presentation/screens/update_screen.dart';
import 'package:noteappkimit/presentation/widgets/container_widget.dart';
import 'package:noteappkimit/presentation/screens/log_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../logic/home/cubit.dart';
import 'package:noteappkimit/presentation/screens/create_note_screen.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override 
  void toggleLanguage (BuildContext context){
    final currentLocal=context.locale;
    if(currentLocal.languageCode=='en'){
      context.setLocale(Locale('ar'));

    }
    else{
      context.setLocale(Locale('en'));
    }
  }
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getNotes(),
      child:
       Scaffold(
        backgroundColor: ColorManager.primaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
              SizedBox(height: 120,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(child: ContainerWidget(buttonTxt: 'Add note'.tr(), buttonhight: 48, buttonwidth: 164),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateNoteScreen()));
                  },
                  ),
                  IconButton(onPressed: (){
                    toggleLanguage(context);

                  }, icon: Icon(Icons.translate)),
                  SizedBox(width: 20,),
                  InkWell(
                    onTap: ()async{
                      // Log out logic
                      final SharedPreferences prefs = await SharedPreferences.getInstance();
                      await prefs.setBool('isLoggedIn', false);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> LogInScreen()));
                    },
                    child: ContainerWidget(buttonTxt: 'Log out'.tr(), buttonhight: 48, buttonwidth: 164)),
              
                ],
              ),
              SizedBox(height: 20,),
             Expanded(
               child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if(state is HomeLoadingStat){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  else if (state is HomeSuccessStat) {
                  return ListView.builder(itemBuilder: (context, index) => InkWell(
                   onTap:(){
                     Navigator.push(context, MaterialPageRoute(builder: (context)=> UpdateScreen(noteDtat:state.notes[index],)));
                   },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                       margin: EdgeInsets.only(bottom: 16),
                       decoration: BoxDecoration(
                         color: ColorManager.txtFeildColor,
                         borderRadius: BorderRadius.circular(10),
                                 
                       ),
                       child: Row(
                         children: [
                         
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                Text(state.notes[index].headline,
                                style: TextStyle(
                                 color: Colors.white,
                                 fontWeight: FontWeight.w500,
                                 fontSize: 14,
                                               
                                ),),
                                Text( state.notes[index].description,style: TextStyle(
                                 color: Colors.white,
                                 fontWeight: FontWeight.w500,
                                 fontSize: 14,
                                 
                                )),
                                 Text(state.notes[index].creatAt.toString(),style: TextStyle( color: Colors.white,
                                 fontWeight: FontWeight.w500,
                                 fontSize: 10,),),
                                IconButton(onPressed: (){
                                  context.read<HomeCubit>().deleteNote(state.notes[index].noteId!);
                                }, icon: Icon(Icons.delete))
                              
                                   
                               ],
                               
                                   
                             ),
                           ),
                           SizedBox(width: 10,),
                          
                         ],
                       ),
                             ),
                    ),
                  )   ,itemCount: state.notes.length,
                         shrinkWrap: true,);
                }
                else if(state is HomeErrorStat){
                 return Center(child: Text(state.em));
                }
               return SizedBox();},
                             
               ),
             )
            ],
          ),
        ),
      ),
    );
  }
}