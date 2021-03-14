import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
/*
class LppImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = AssetImage('assets/lpp_bezpozadine.png');
    Image image = Image(
      image: assetImage,
    );
    return Container(
      child: image,
    );
  }
}*/

class _MyHomePageState extends State<MyHomePage> {
  File file;
  void openGatePhoto() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      file = image;
    });
    showDialog(
        context: context,
        builder: (context) => CustomDialogOpen(
              title: "Gates are open",
              description:
                  "Licence plate numbers have been successfully stored in the database",
            ));
  }

  void closeGatePhoto() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      file = image;
    });
    showDialog(
        context: context,
        builder: (context) => CustomDialogClosed(
              title: "Gates are closed",
              description:
                  "Licence plate numbers are not in the paid bracket, please pay for the parking",
            ));
  }

  @override
  Widget build(BuildContext context) {
    const darkBlueColor = const Color(0xff131f40);
    const lightBlueColor = const Color(0xff445c9e);
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    darkBlueColor,
                    lightBlueColor,
                  ],
                  stops: [0.5, 1],
                  begin: const FractionalOffset(0.5, 0.25),
                  end: const FractionalOffset(1, 1),
                ),
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.09),
              Positioned(
                  top: 50,
                  left: 100,
                  right: 100,
                  child: Align(
                      child: Image.asset(
                    'assets/lpp_bezpozadine.png',
                    scale: 2.6,
                  ))),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: MediaQuery.of(context).size.height * 0.22,
                  child: RaisedButton(
                    color: Colors.transparent,
                    onPressed: () {
                      openGatePhoto();
                    },
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.white,
                            width: 3,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(
                      "Open the Gate",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.045),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.80,
                  height: MediaQuery.of(context).size.height * 0.22,
                  child: RaisedButton(
                    color: Colors.transparent,
                    onPressed: () {
                      closeGatePhoto();
                    },
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: Colors.white,
                            width: 3,
                            style: BorderStyle.solid),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Text(
                      "Close the Gate",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//Popup Screen open

class CustomDialogOpen extends StatelessWidget {
  final String title, description, buttonText;
  final Image image;
  CustomDialogOpen({this.title, this.description, this.buttonText, this.image});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: dialogContent(context),
        ));
  }

  dialogContent(BuildContext context) {
    const darkBlueColor = const Color(0xff131f40);
    return Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.16,
                bottom: MediaQuery.of(context).size.height * 0.04,
                left: MediaQuery.of(context).size.width * 0.04,
                right: MediaQuery.of(context).size.width * 0.04),
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.113),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20.0,
                    offset: Offset(0.0, 10.0),
                  )
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w700,
                      color: darkBlueColor),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.065),
                Text(
                  description,
                  style: TextStyle(fontSize: 25, color: darkBlueColor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Continue',
                        style: TextStyle(fontSize: 20, color: darkBlueColor)),
                  ),
                )
              ],
            )),
        Positioned(
            top: 0,
            left: 16,
            right: 16,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 80,
              child: ClipOval(
                child: Image.asset('assets/yes_blank.gif'),
              ),
            ))
      ],
    );
  }
}

//Popup Screen closed

class CustomDialogClosed extends StatelessWidget {
  final String title, description, buttonText;
  final Image image;
  CustomDialogClosed(
      {this.title, this.description, this.buttonText, this.image});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: dialogContent(context),
        ));
  }

  dialogContent(BuildContext context) {
    const darkBlueColor = const Color(0xff131f40);
    return Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.16,
                bottom: MediaQuery.of(context).size.height * 0.04,
                left: MediaQuery.of(context).size.width * 0.04,
                right: MediaQuery.of(context).size.width * 0.04),
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.113),
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20.0,
                    offset: Offset(0.0, 10.0),
                  )
                ]),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 35.0,
                      fontWeight: FontWeight.w700,
                      color: darkBlueColor),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.065),
                Text(
                  description,
                  style: TextStyle(fontSize: 25, color: darkBlueColor),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: FloatingActionButton(
                          onPressed: () {
                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                builder: (context) => CustomDialogOpen(
                                      title: "Gates are open",
                                      description:
                                          "Manual override successful \n Have a safe trip",
                                    ));
                          },
                          child: Icon(Icons.power_settings_new_rounded),
                          backgroundColor: Colors.greenAccent,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Continue',
                              style: TextStyle(
                                  fontSize: 20, color: darkBlueColor)),
                        ),
                      )
                    ]),
              ],
            )),
        Positioned(
            top: 0,
            left: MediaQuery.of(context).size.width * 0.04,
            right: MediaQuery.of(context).size.width * 0.04,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 80,
              child: ClipOval(
                child: Image.asset('assets/no_blank.gif'),
              ),
            ))
      ],
    );
  }
}
