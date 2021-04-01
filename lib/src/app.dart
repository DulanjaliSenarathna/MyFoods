import 'package:MyFoods/src/admin/pages/add_food_item.dart';
import 'package:MyFoods/src/pages/signin_page.dart';
import 'package:MyFoods/src/scoped-model/main_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'screens/main_screen.dart';


class App extends StatelessWidget
{

 final MainModel mainModel = MainModel();

  @override
  Widget build(BuildContext context)
  {
    return ScopedModel<MainModel>(
      model: mainModel,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "My Foods",
        theme: ThemeData(primaryColor:Colors.blueAccent),
       // home: MainScreen(model:mainModel),
       // home: AddFoodItem(),
       routes: {
         '/' : (BuildContext context) => SignInPage(),
        '/mainscreen' : (BuildContext context) => MainScreen(),
         
       },
      ),

    );
  }
}