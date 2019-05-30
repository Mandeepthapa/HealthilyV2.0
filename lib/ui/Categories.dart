import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:healthily_v2/card_data.dart';
import 'package:healthily_v2/ui/BottomBar.dart';
import 'package:healthily_v2/ui/CardFlipper.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  double scrollPercent = 0.0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: Text("CATEGORIES",
            style: TextStyle(
              fontFamily: 'WoksSansMedium'
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text("Mandeep Thapa"),
                accountEmail: Text("mandeep.thapa20@gmail.com"),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/yog.jpg"),
                    fit: BoxFit.fill
                  )
                ),
              ),
              ListTile(
                title: Text("Events"),
                trailing: Icon(Icons.event),
                onTap: (){},
              ),
              Divider(),
              ListTile(
                title: Text("Calander"),
                trailing: Icon(Icons.calendar_today),
                onTap: (){},
              ),
              Divider(),
              ListTile(
                title: Text("About"),
                trailing: Icon(Icons.book),
                onTap: (){},
              ),
              Divider(),
              ListTile(
                title: Text("Logout"),
                trailing: Icon(Icons.exit_to_app),
                onTap: (){},
              ),
            ],
          ),
        ),
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //Status bar
            new Container(
              width: double.infinity,
              height: 20.0,
            ),
            //Card
            Expanded(
              child: CardFlipper(
                  cards: demoCards,
                  onScroll: (double scrollPercent) {
                    setState(() {
                      this.scrollPercent = scrollPercent;
                    });
                  }),
            ),
            //Bottom Bar
            BottomBar(cardCount: demoCards.length, scrollPercent: scrollPercent)
          ],
        ),
      ),
    );
  }
}



