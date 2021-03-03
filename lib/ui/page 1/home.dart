import 'package:flutter/material.dart';
import 'package:flutter_recipe_app/ui/page%201/cardBundle/bestof2020.dart';
import 'package:flutter_recipe_app/ui/page%201/cardBundle/cookSomething.dart';
import 'package:flutter_recipe_app/ui/page%201/cardBundle/foodCourt.dart';
import 'package:flutter_recipe_app/ui/searchDelegate/searchDelegate.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: 'Recipe',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: 'PoppinsBold')),
              TextSpan(
                  text: ' App',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontFamily: 'PoppinsBold')),
            ],
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: ProductSearch());
              },
              icon: Icon(Icons.search, color: Colors.black)),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(20.0), //,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CookSomething()));
                    },
                    child: recipeBundle(
                        recipeColor: Color(0xFFD82D40),
                        recipeTitle: "Cook Something\nNew Everyday",
                        repiceDesc: "New and tasty\nrecipes every minute",
                        imageSrc: 'images/cook_new@2x.png'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => BestOf2020()));
                    },
                    child: recipeBundle(
                        recipeColor: Color(0xFF90AF17),
                        recipeTitle: 'Best of 2021',
                        repiceDesc: 'Cook recipes\nfor special occasions',
                        imageSrc: 'images/best_2020@2x.png'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => FoodCourt()));
                    },
                    child: recipeBundle(
                        recipeColor: Color(0xFF2DBBD8),
                        recipeTitle: 'Food Court',
                        repiceDesc:
                            'Whats your favorite\nfood dish make it now',
                        imageSrc: "images/food_court@2x.png"),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}

Container recipeBundle(
    {@required Color recipeColor,
    @required String recipeTitle,
    @required String repiceDesc,
    @required String imageSrc}) {
  double defaultSize = 10;

  return Container(
    height: 240,
    width: double.infinity,
    decoration: BoxDecoration(
      color: recipeColor,
      borderRadius: BorderRadius.circular(defaultSize * 1.8), //18
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(defaultSize * 2), //20
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                recipeTitle,
                style: TextStyle(
                    fontSize: defaultSize * 2.2, //22
                    fontFamily: 'PoppinsBold',
                    color: Colors.white),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: defaultSize * 0.5), // 5
              Text(
                repiceDesc,
                style:
                    TextStyle(color: Colors.white54, fontFamily: 'PoppinsReg'),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        SizedBox(width: defaultSize * 0.5), //5
        Expanded(
          child: Image.asset(
            imageSrc,
            fit: BoxFit.cover,
            alignment: Alignment.centerLeft,
          ),
        ),
      ],
    ),
  );
}
