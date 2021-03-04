import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddRecipe extends StatefulWidget {
  @override
  _AddRecipeState createState() => _AddRecipeState();
}

class _AddRecipeState extends State<AddRecipe> {
  final TextEditingController nameFoodController = TextEditingController();
  final TextEditingController descriptionProductController =
      TextEditingController();
  final TextEditingController ingredientsFoodController =
      TextEditingController();

  //details shit

  final _formKey = GlobalKey<FormState>();

  // drop down bottom
  String selectedFoodCategory = 'Cook Something';
  List listFoodCategory = [
    'Best Of 2020',
    'Cook Something',
    'Food Court',
  ];

  String totalTimesCook = '> 30 Minute';
  List totalTimesCooks = [
    '> 30 Minute',
    '< 30 Minute',
  ];

  // get local image
  File image;
  Future getImage(ImageSource sourceImage) async {
    // Get image from gallery.
    // ignore: deprecated_member_use
    File imageFile = await ImagePicker.pickImage(source: sourceImage);

    if (imageFile != null) {
      setState(() {
        image = imageFile;
      });
    }
  }

  _showImage() {
    if (image == null) {
      return SizedBox(height: 0);
    } else if (image != null) {
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.file(
            image,
            fit: BoxFit.cover,
            height: 250,
          ),
        ],
      );
    } else {
      return Text('EROR');
    }
  }

  String imageLocation;
  Future<void> _uploadImageToFirebase() async {
    try {
      // Make random image name.
      int randomNumber = Random().nextInt(100000);
      // ignore: unnecessary_brace_in_string_interps
      imageLocation = 'images/image${randomNumber}.jpg';

      // Upload image to firebase.
      final Reference storageReference =
          FirebaseStorage.instance.ref().child(imageLocation);
      final UploadTask uploadTask = storageReference.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask;

      _addPathToDatabase(imageLocation, taskSnapshot, uploadTask);
    } catch (e) {
      print(e.message);
    }
  }

  Future<void> _addPathToDatabase(
      String text, TaskSnapshot a, UploadTask uploadTask) async {
    // Get image URL from firebase
    String url = (await a.ref.getDownloadURL());
    print('URL Is $url');
    print('product controller ${nameFoodController.text}');

    //search Index Function
    List<String> splitList = nameFoodController.text.split(' ');
    List<String> indexList = [];

    for (int i = 0; i < splitList.length; i++) {
      for (int j = 0; j < splitList[i].length + i; j++) {
        indexList.add(splitList[i].substring(0, j).toLowerCase());
        indexList.add(splitList[i].substring(0, j).toUpperCase());
      }
    }

    // search
    for (int i = 0; i < 2; i++) {
      indexList.add(nameFoodController.text.toLowerCase());
      indexList.add(nameFoodController.text.toUpperCase());
      indexList.add(nameFoodController.text);
    }

    // dateTime now
    DateTime now = DateTime.now();
    var currentTime =
        new DateTime(now.year, now.month, now.day, now.hour, now.minute);

    //TODO: Change this plz
    if (url != null) {
      await FirebaseFirestore.instance.collection(selectedFoodCategory).add({
        'name': nameFoodController.text,
        'stock': ingredientsFoodController.text ?? 1,
        'description': descriptionProductController.text,
        'totalFoodCook': totalTimesCook,
        'url': url,
        'date': currentTime,
      });

      await FirebaseFirestore.instance.collection('allFood').add({
        'name': nameFoodController.text,
        'stock': ingredientsFoodController.text ?? 1,
        'description': descriptionProductController.text,
        'totalFoodCook': totalTimesCook,
        'url': url,
        'searchIndex': indexList,
        'date': currentTime,
      });
    }
  }

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
                  text: 'Add',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: 'PoppinsBold')),
              TextSpan(
                  text: ' Recipe',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontFamily: 'PoppinsBold')),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                verticalDirection: VerticalDirection.down,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        _showImage(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            (image == null)
                                // ignore: deprecated_member_use
                                ? FlatButton(
                                    height: 45,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    color: Color(0xFF2DBBD8),
                                    onPressed: () =>
                                        getImage(ImageSource.gallery),
                                    child: Text('Add Image',
                                        style: TextStyle(
                                            fontFamily: 'PoppinsBold',
                                            color: Colors.white,
                                            fontSize: 16)),
                                  )
                                : SizedBox(height: 0),
                            (image == null)
                                // ignore: deprecated_member_use
                                ? FlatButton(
                                    height: 45,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    color: Color(0xFF2DBBD8),
                                    onPressed: () =>
                                        getImage(ImageSource.camera),
                                    child: Text('Take a picture',
                                        style: TextStyle(
                                            fontFamily: 'PoppinsBold',
                                            color: Colors.white,
                                            fontSize: 16)),
                                  )
                                : SizedBox(height: 0),
                          ],
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              fontFamily: 'PoppinsReg', color: Colors.black),

                          // add controller
                          controller: nameFoodController,

                          decoration: InputDecoration(
                            labelText: 'Food Name',
                            labelStyle: TextStyle(
                                fontFamily: 'PoppinsBold', color: Colors.black),
                          ),
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Cant be a Empty!';
                            }
                            if (val.length < 5) {
                              return 'Product name must more than 5';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              fontFamily: 'PoppinsReg', color: Colors.black),
                          minLines: 4,
                          maxLines: 30,

                          // add controller
                          controller: descriptionProductController,

                          decoration: InputDecoration(
                            labelText: 'Description',
                            labelStyle: TextStyle(
                                fontFamily: 'PoppinsBold', color: Colors.black),
                          ),
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Cant be a Empty!';
                            }
                            if (val.length < 10) {
                              return 'Description product must more than 10';
                            }
                            if (val.length > 200) {
                              return 'Description product must less than 200';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              fontFamily: 'PoppinsReg', color: Colors.black),
                          minLines: 4,
                          maxLines: 30,

                          // add controller
                          controller: ingredientsFoodController,

                          decoration: InputDecoration(
                            labelText: 'Ingredients',
                            labelStyle: TextStyle(
                                fontFamily: 'PoppinsBold', color: Colors.black),
                          ),
                          validator: (val) {
                            if (val.isEmpty) {
                              return 'Cant be a Empty!';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                  //TODO: ADD MORE DETAILS
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Food Category',
                          style: TextStyle(
                              fontFamily: 'PoppinsBold',
                              color: Colors.black,
                              fontSize: 16)),
                      Text('Total Time Cook',
                          style: TextStyle(
                              fontFamily: 'PoppinsBold',
                              color: Colors.black,
                              fontSize: 16)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButton(
                          items:
                              listFoodCategory.map<DropdownMenuItem>((value) {
                            return DropdownMenuItem(
                                child: Text(value), value: value);
                          }).toList(),

                          // text
                          value: selectedFoodCategory,
                          style: TextStyle(
                              fontFamily: 'PoppinsReg', color: Colors.black),
                          onChanged: (value) {
                            setState(() {
                              selectedFoodCategory = value;
                            });
                          },
                        ),
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton(
                          items: totalTimesCooks.map<DropdownMenuItem>((value) {
                            return DropdownMenuItem(
                                child: Text(value), value: value);
                          }).toList(),

                          // text
                          value: totalTimesCook,
                          style: TextStyle(
                              fontFamily: 'PoppinsReg', color: Colors.black),
                          onChanged: (value) {
                            setState(() {
                              totalTimesCook = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  //TODO: look this shit
                  SizedBox(height: 10),
                  Center(
                    // ignore: deprecated_member_use
                    child: FlatButton(
                      height: 50,
                      minWidth: double.infinity,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      color: Color(0xFF90AF17),
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          //Add Image Data
                          _uploadImageToFirebase();
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text("Add Recipe",
                          style: TextStyle(
                              fontFamily: 'PoppinsBold',
                              color: Colors.white,
                              fontSize: 16)),
                    ),
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
