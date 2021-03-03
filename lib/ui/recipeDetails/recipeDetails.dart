import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  // for like button
  bool likeButton;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
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
                  text: ' Details',
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF016DF7),
                      fontFamily: 'PoppinsBold')),
            ],
          ),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.favorite,
                  color: likeButton ? Colors.red : Colors.white),
              onPressed: () {
                setState(() {
                  likeButton = !likeButton;
                });

                if (likeButton) {
                  //TODO: ADD TO DATABASE
                }

                if (!likeButton) {
                  //TODO: DELETE DATABASE
                }
              })
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              //TODO: ADD ETC..
            ],
          ),
        ),
      ),
    );
  }
}
