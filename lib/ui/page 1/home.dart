import 'package:flutter/material.dart';
import 'package:flutter_recipe_app/ui/searchDelegate/searchDelegate.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: _appBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //TODO: add etc
              // recipebundlecard(),
              // recipebundlecard(),
              // recipebundlecard(),
            ],
          ),
        ),
      ),
    );
  }

  //AppBar
  AppBar _appBar() {
    return AppBar(
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
                    color: Color(0xFF016DF7),
                    fontFamily: 'PoppinsBold')),
          ],
        ),
      ),
      actions: [
        IconButton(
            onPressed: () {
              // showSearch(context: context, delegate: ProductSearch());
            },
            icon: Icon(Icons.search, color: Colors.black)),
      ],
    );
  }

  // recipe bundle card
  Container recipebundlecard(
      {String recipeBundleTitle,
      Color containerColor,
      String recipeBundledescription,
      String recipeBundlerecipes,
      String recipeBundlechefs,
      String imageLocation}) {
    return Container(
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(20), //18
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(
                  (MediaQuery.of(context).size.width * 0.024) * 2), //20
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Spacer(),
                  Text(
                    recipeBundleTitle,
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 2.2, //22
                        color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                      height: (MediaQuery.of(context).size.width * 0.024) *
                          0.5), // 5
                  Text(
                    recipeBundledescription,
                    style: TextStyle(color: Colors.white54),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Spacer(),
                  buildInfoRow(
                    (MediaQuery.of(context).size.width * 0.024),
                    // iconSrc: "assets/icons/pot.svg",
                    text: recipeBundlerecipes + " Recipes",
                  ),
                  SizedBox(
                      height: (MediaQuery.of(context).size.width * 0.024) *
                          0.5), //5
                  buildInfoRow(
                    (MediaQuery.of(context).size.width * 0.024),
                    // iconSrc: "assets/icons/chef.svg",
                    text: recipeBundlechefs + " Chefs",
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
          SizedBox(
              width: (MediaQuery.of(context).size.width * 0.024) * 0.5), //5
          AspectRatio(
            aspectRatio: 0.71,
            child: Image.asset(
              imageLocation,
              fit: BoxFit.cover,
              alignment: Alignment.centerLeft,
            ),
          )
        ],
      ),
    );
  }

  // recipe info
  Row buildInfoRow(double defaultSize, {String text}) {
    return Row(
      children: <Widget>[
        // iconSrc == null ? SvgPicture.asset(iconSrc) : SizedBox(height: 0),
        SizedBox(width: defaultSize), // 10
        Text(
          text,
          style: TextStyle(
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
