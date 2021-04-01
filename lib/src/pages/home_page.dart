
import 'package:MyFoods/src/pages/food_details_page.dart';
import 'package:MyFoods/src/scoped-model/food_model.dart';
import 'package:MyFoods/src/scoped-model/main_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/home_top_info.dart';
import '../widgets/food_category.dart';
import '../widgets/search_field.dart';
import '../widgets/bought_foods.dart';


import '../models/food_model.dart';

class HomePage extends StatefulWidget
{
// final FoodModel foodModel;

// HomePage(this.foodModel);

  @override
  _HomePageState  createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{

  @override
  void initState() {
    //widget.foodModel.fetchFoods();
    super.initState();
  }
 
   @override
   Widget build(BuildContext context)
   {
     return Scaffold(
       backgroundColor: Colors.white,
       body: ListView(
         padding: EdgeInsets.only(left:20.0, right:20.0),
         children:<Widget>[
          HomeTopInfo(),
          FoodCategory(),
          SizedBox(height:20.0,),
          SearchField(),
          SizedBox(height:20.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget> [
              Text(
                "Frequently bought foods",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight:FontWeight.bold),
                ),
              GestureDetector(
                onTap: (){},
                  child: Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight:FontWeight.bold,
                    color: Colors.orangeAccent,
                    ),  
                  ),
              ),  
            ],
          ),
          SizedBox(height:20.0),
         ScopedModelDescendant<MainModel>(
           builder: (BuildContext context, Widget child, MainModel model )
           {
             return Column(
            children: model.foods.map(_buildFoodItems).toList(),
          );
           },
           ),
         ],
       ),
     );
   }

   Widget _buildFoodItems(Food food)
   {
     return GestureDetector(
       onTap: ()
       {
         Navigator.of(context).push(MaterialPageRoute(
           builder: (BuildContext context) => FoodDetailsPage(
             food:food,
           ),
          ));
       },
       child: Container(
       margin: EdgeInsets.only(bottom:20.0),
       child: BoughtFoods(
         id: food.id,
         name: food.name,
         imagePath: "assets/images/breakfast.jpeg",
         category: food.category,
         discount: food.discount,
         price: food.price,
         ratings: food.ratings,
       ),
     ),
     );
   }
}