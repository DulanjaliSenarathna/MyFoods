import 'package:MyFoods/src/admin/pages/add_food_item.dart';
import 'package:MyFoods/src/models/food_model.dart';
import 'package:MyFoods/src/scoped-model/main_model.dart';
import 'package:MyFoods/src/widgets/food_item_card.dart';
import 'package:MyFoods/src/widgets/show_dialog.dart';
import 'package:MyFoods/src/widgets/small_button.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ExplorePage extends StatefulWidget
{
  final MainModel model;

  ExplorePage({this.model});
  @override
  _ExplorePageState  createState() => _ExplorePageState();
}

class _ExplorePageState extends State< ExplorePage>{

GlobalKey <ScaffoldState> _explorePageScafofoldKey = GlobalKey();
@override
  void initState() {
   
    super.initState();
    
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      key: _explorePageScafofoldKey,
      backgroundColor: Colors.white,
      body: ScopedModelDescendant <MainModel>(
          builder: (BuildContext sctx, Widget child, MainModel model)
          {
            //model.fetchFoods();//this will fetch and notifylisteners()
            //List<Food> foods = model.foods;
            return Container(
              padding: EdgeInsets.symmetric(horizontal:20.0),
          child: RefreshIndicator(
            onRefresh: model.fetchFoods,
          child: ListView.builder(
          itemCount: model.foodLength,
          itemBuilder: (BuildContext lctx, int index)
          {
            return GestureDetector(
              onTap: () async
              {
                final bool response = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) => AddFoodItem(
                    food : model.foods[index],
                  ))
                );
                if(response)
                {
                  SnackBar snackbar = SnackBar(
                            duration: Duration(seconds:2),
                            backgroundColor: Theme.of(context).primaryColor,
                          content: Text("Food item successfully updated",
                          style: TextStyle(color:Colors.white,fontSize:16.0),),
                          );
                          _explorePageScafofoldKey.currentState.showSnackBar(snackbar);
                }
              },
              onDoubleTap: ()
              {
                //delete food item
                showLoadingIndicator(context, "Deleting food item..");
                model.deleteFood(model.foods[index].id).then((bool response)
                {
                  Navigator.of(context).pop();
                });
              },
              child: FoodItemCard(
                model.foods[index].name,
                model.foods[index].description,
               model.foods[index].price.toString(),
              ),
            );
          },
    ),
                          ),
            );
          },
        )
    );
  }
}

// Container(
//         color: Colors.white,
//         padding: EdgeInsets.symmetric(horizontal:16.0),
//         child: ScopedModelDescendant <MainModel>(
//           builder: (BuildContext context, Widget child, MainModel model)
//           {
//             model.fetchFoods();
//             List<Food> foods = model.foods;
//             return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: foods.map((Food food)
//           {
//             return FoodItemCard(
//               food.name,
//               food.description,
//               food.price.toString(),
//             );
//           }).toList(),
//     );
//           },
//         ),
//       ),