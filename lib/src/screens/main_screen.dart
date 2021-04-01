import 'package:MyFoods/src/admin/pages/add_food_item.dart';
import 'package:MyFoods/src/pages/explore_page.dart';
import 'package:MyFoods/src/pages/profile_page.dart';
import 'package:MyFoods/src/scoped-model/main_model.dart';
import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/order_page.dart';


class MainScreen extends StatefulWidget
{

final MainModel model;

MainScreen({this.model});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
{

int currentTabIndex = 0;

List <Widget> pages;
Widget currentPage;

HomePage homePage;
OrderPage orderPage;
ExplorePage explorePage;
ProfilePage profilePage;

@override
  void initState() {
    
    //call the fetch method on food
    //widget.foodModel.fetchFoods();
    //widget.model.fetchFoods();
    
    homePage = HomePage();
    orderPage = OrderPage();
    explorePage = ExplorePage(model: widget.model,);
    profilePage = ProfilePage();

    pages = [homePage, explorePage,orderPage, profilePage]; //Array of pages

    currentPage = homePage;
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
    return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          backgroundColor:Colors.white,
          elevation:0,
          iconTheme: IconThemeData(color:Colors.black),
          title: Text(
          currentTabIndex == 0 ? "My Foods" : currentTabIndex == 1 ? "All Food Items" : currentTabIndex == 2 ? "Orders" : "Profile", 
          style: TextStyle(
              color:Colors.black, 
              fontSize:16.0, 
              fontWeight:FontWeight.bold),),
          centerTitle: true,
          actions:<Widget> [ 
            IconButton(icon: Icon(Icons.notifications_none,  color: Theme.of(context).primaryColor,), onPressed: (){}),
             IconButton(icon: _buildShoppingCard(), onPressed: (){})
        
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              ListTile(
                onTap: ()
                {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) => AddFoodItem())
                  );
                },
                leading:Icon(Icons.list),
                title: Text("Add Food Item", style:TextStyle(fontSize: 16.0)),

              )
            ],
          ),
        ),
        resizeToAvoidBottomPadding: false,
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index){
            setState(() {
              currentTabIndex = index;
              currentPage = pages[index];
            });
          },
          currentIndex: currentTabIndex,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text("Home")
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              title: Text("Explore")
              ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
               title: Text("Orders")
              ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
               title: Text("Profile")
              ),
          ],
        ),
        body: currentPage,
      ),
    ); 
  }

  Widget _buildShoppingCard()
  {
    return Stack(
      children: <Widget>[
       
        Icon(Icons.shopping_cart, color: Theme.of(context).primaryColor,
        ),
       Positioned(
         top: 0.0,
         right: 0.0,
         child:  Container(
          height: 12.0,
          width: 12.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color:Colors.red 
          ),
          child: Center(
            child:Text("1", style:TextStyle(fontSize: 12.0, color:Colors.white,),),
          ),
        ),
       ),
      ],
    );
  }
}