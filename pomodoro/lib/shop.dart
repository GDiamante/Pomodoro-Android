import 'package:flutter/material.dart';
import 'main.dart';
import 'customize.dart';
import 'hexcolor.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'globalvars.dart' as globals;

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreen createState() => _ShopScreen();
}

class _ShopScreen extends State<ShopScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Shop"),
        elevation: 0,
        backgroundColor: HexColor.fromHex(globals.primaryColor),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
            child: Row(children: <Widget>[
              IconButton(
                icon: Icon(Icons.attach_money),
                onPressed: () {},
              ),
              new Text(globals.shopCurrency.toString()),
            ]),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: Container(
        color: HexColor.fromHex(globals.offWhiteColor),
        child: Container(
          child: ListView(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Card(
                child: Column(children: [
                  Text(
                    "Todays deals",
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CarouselSlider(
                    items: globals.items
                        .map((item) => new imageSlide(
                      id: item.id,
                      myShop: this,
                    ))
                        .toList(),
                    options: CarouselOptions(
                      height: 250,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Card(
                child: Column(children: [
                  Text(
                    "Weekly Colour Combinations",
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 280,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
                      child: Container(
                        child: GridView.count(
                          childAspectRatio: 1.5,
                          primary: false,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          children: globals.combinations
                              .map((comb) => new combination(
                            id: comb.id,
                            myShop: this,
                          ))
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class combAlert extends StatefulWidget {
  final String id;
  _ShopScreen myShop;
  State itemState;

  combAlert(
      {Key key,
        @required this.id,
        @required this.myShop,
        @required this.itemState});

  @override
  _combAlert createState() => _combAlert();
}

class _combAlert extends State<combAlert> {
  int state = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Purchase Item?"),
      actions: [
        new ButtonBar(
          alignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new TextButton(
              child: Text((() {
                switch (state) {
                  case 0:
                    return "Purchase";
                    break;
                  case 1:
                    return "Continue";
                    break;
                  default:
                    return "Complete";
                }
              })()),
              onPressed: () {
                setState(() {
                  if (state == 0 && globals.shopCurrency > globals.shopItems[widget.id].price) {
                    state++;
                    globals.shopCurrency -= globals.shopItems[widget.id].price;
                    globals.shopItems[widget.id].purchased = true;
                    globals.purchasedItems[widget.id] = globals.shopItems[widget.id];
                    globals.writeFile();
                    widget.myShop.setState(() {});
                    var parentState = null;
                    if (widget.itemState is _imageSlide) {
                      parentState = widget.itemState as _imageSlide;
                      parentState.setState(() {});
                    } else if (widget.itemState is _combination) {
                      parentState = widget.itemState as _combination;
                      parentState.setState(() {});
                    }
                  } else if (state == 1) {
                    Navigator.of(context).pop();
                  } else {
                    Navigator.of(context).pop();
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return failedAlert();
                        });
                  }
                });
              },
            ),
            new TextButton(
              child: Text((() {
                switch (state) {
                  case 0:
                    return "Cancel";
                    break;
                  case 1:
                    return "Customize";
                    break;
                  default:
                    return "Cancel";
                }
              })()),
              onPressed: () {
                if (state == 0) {
                  Navigator.of(context).pop();
                } else {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => CustomizeScreen()));
                }
              },
            ),
          ],
        ),
      ],
      content: Container(
        height: 250,
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(width: 1.0),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: (globals.shopItems[widget.id] is globals.combinationShopItem)
                  ? ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Container(
                    color: HexColor.fromHex(globals.shopItems[widget.id].primaryColour),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: SizedBox(
                          width: 35.0,
                          height: 35.0,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.0),
                              color:
                              HexColor.fromHex(globals.shopItems[widget.id].secondaryColour),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ))
                  : ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: SizedBox.expand(
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(globals.shopItems[widget.id].imageURL))),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: <Color>[
                              Colors.black.withAlpha(0),
                              Colors.black12,
                              Colors.black45
                            ],
                          ),
                        ),
                      ),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Text(
                globals.shopItems[widget.id].price.toString() + " points",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class failedAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text("Failed to purchase."),
        content: Text("Missing required funds."),
        actions: [
          new TextButton(
            child: Text("Continue"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ]);
  }
}

class combination extends StatefulWidget {
  final String id;
  _ShopScreen myShop;

  combination(
      {Key key,
        @required this.id,
        @required this.myShop});

  @override
  _combination createState() => _combination();
}

class _combination extends State<combination> {

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (globals.shopItems[widget.id].purchased) return;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return combAlert(
              id: widget.id,
              myShop: widget.myShop,
              itemState: this,
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Container(
              color: HexColor.fromHex(globals.shopItems[widget.id].primaryColour),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 25),
                        child: SizedBox(
                          width: 25.0,
                          height: 25.0,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.0),
                              color: HexColor.fromHex(globals.shopItems[widget.id].secondaryColour),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          (() {
                            if (globals.shopItems[widget.id].purchased) {
                              return 'Purchased!';
                            } else {
                              return globals.shopItems[widget.id].price.toString() + ' points';
                            }
                          }()),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ]),
            )),
      ),
    );
  }
}

class imageSlide extends StatefulWidget {
  final String id;
  _ShopScreen myShop;

  imageSlide(
      {Key key,
        @required this.id,
        @required this.myShop});

  @override
  _imageSlide createState() => _imageSlide();
}

class _imageSlide extends State<imageSlide> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          if (globals.shopItems[widget.id].purchased) return;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return combAlert(
                id: widget.id,
                myShop: widget.myShop,
                itemState: this,
              );
            },
          );
        },
        child: Container(
          margin: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          decoration: BoxDecoration(
            border: Border.all(width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: SizedBox.expand(
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover, image: NetworkImage(globals.shopItems[widget.id].imageURL))),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Colors.black.withAlpha(0),
                          Colors.black12,
                          Colors.black45
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          (() {
                            if (globals.shopItems[widget.id].purchased) {
                              return 'Purchased!';
                            } else {
                              return globals.shopItems[widget.id].price.toString() + ' points';
                            }
                          }()),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }
}

