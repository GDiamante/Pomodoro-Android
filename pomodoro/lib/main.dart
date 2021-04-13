import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'globalvars.dart' as globals;
import 'globalvars.dart';
import 'hexcolor.dart';

void main() {
  globals.populateMap();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: new HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: HexColor.fromHex(globals.primaryColor),
        elevation: 0,
      ),
      backgroundColor: HexColor.fromHex(globals.primaryColor),
      drawer: MyDrawer(),
    );
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
        if (globals.hashMap[widget.id].purchased) return;
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
              color: HexColor.fromHex(globals.hashMap[widget.id].primaryColour),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                        child: SizedBox(
                          width: 25.0,
                          height: 25.0,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1.0),
                              color: HexColor.fromHex(globals.hashMap[widget.id].secondaryColour),
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
                              if (globals.hashMap[widget.id].purchased) {
                                return 'Purchased!';
                              } else {
                                return globals.hashMap[widget.id].price.toString() + ' points';
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
          if (globals.hashMap[widget.id].purchased) return;
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
                      fit: BoxFit.cover, image: NetworkImage(globals.hashMap[widget.id].imageURL))),
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
                        if (globals.hashMap[widget.id].purchased) {
                          return 'Purchased!';
                        } else {
                          return globals.hashMap[widget.id].price.toString() + ' points';
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
                    height: 200,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(25, 15, 25, 0),
                      child: Container(
                        child: GridView.count(
                          childAspectRatio: (200 + 20) / 100,
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
                  if (state == 0 && globals.shopCurrency > globals.hashMap[widget.id].price) {
                    state++;
                    globals.shopCurrency -= globals.hashMap[widget.id].price;
                    globals.hashMap[widget.id].purchased = true;
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
              child: (globals.hashMap[widget.id] is globals.combinationShopItem)
                  ? ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      child: Container(
                        color: HexColor.fromHex(globals.hashMap[widget.id].primaryColour),
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
                                      HexColor.fromHex(globals.hashMap[widget.id].secondaryColour),
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
                                image: NetworkImage(globals.hashMap[widget.id].imageURL))),
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
                globals.hashMap[widget.id].price.toString() + " points",
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

class CustomizeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Customize"),
        elevation: 0,
        backgroundColor: HexColor.fromHex(globals.primaryColor),
      ),
      drawer: MyDrawer(),
    );
  }
}

class _SettingsScreen extends State<SettingsScreen> {
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Settings"),
          elevation: 0,
          backgroundColor: HexColor.fromHex(globals.primaryColor),
        ),
        drawer: MyDrawer(),
        body: Container(
          color: HexColor.fromHex(globals.offWhiteColor),
          child: ListView(
            children: <Widget>[
              Divider(
                height: 20,
                color: HexColor.fromHex(globals.offWhiteColor),
              ),
              Text("Notifications",
                  style: TextStyle(
                    fontSize: 20,
                  )),
              Card(
                  child: Column(children: [
                SwitchListTile(
                  title: Text("Banners"),
                  value: globals.bannerNotifications,
                  onChanged: (bool val) {
                    setState(() {
                      globals.bannerNotifications = val;
                    });
                  },
                ),
                SwitchListTile(
                  title: Text("Lock Screen"),
                  value: globals.lockNotifications,
                  onChanged: (bool val) {
                    setState(() {
                      globals.lockNotifications = val;
                    });
                  },
                ),
                SwitchListTile(
                  title: Text("Notification Center"),
                  value: globals.centerNotifications,
                  onChanged: (bool val) {
                    setState(() {
                      globals.centerNotifications = val;
                    });
                  },
                )
              ])),
              Divider(
                height: 20,
                color: HexColor.fromHex(globals.offWhiteColor),
              ),
              Text("Miscellaneous",
                  style: TextStyle(
                    fontSize: 20,
                  )),
              Container(
                child: Card(
                    child: Column(children: [
                  SwitchListTile(
                    title: Text("Sound effects"),
                    value: globals.soundEffects,
                    onChanged: (bool val) {
                      setState(() {
                        globals.soundEffects = val;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text("Prevent Screen Lock"),
                    value: globals.preventScreenLock,
                    onChanged: (bool val) {
                      setState(() {
                        globals.preventScreenLock = val;
                      });
                    },
                  ),
                  SwitchListTile(
                    title: Text("Vibrate on Silent Mode"),
                    value: globals.vibrateOnSilent,
                    onChanged: (bool val) {
                      setState(() {
                        globals.vibrateOnSilent = val;
                      });
                    },
                  )
                ])),
              ),
              Divider(
                height: 20,
                color: HexColor.fromHex(globals.offWhiteColor),
              ),
              Card(
                  child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(children: [
                  Text("USERNAME"),
                  TextButton(
                    child: Text("LOGOUT"),
                    style: TextButton.styleFrom(
                      backgroundColor: HexColor.fromHex(globals.primaryColor),
                      onSurface: Colors.white,
                      elevation: 5,
                      textStyle:
                          TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                    ),
                  )
                ]),
              ))
            ],
          ),
        ));
  }
}

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreen createState() => _SettingsScreen();
}

class AnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Analytics"),
        elevation: 0,
        backgroundColor: HexColor.fromHex(globals.primaryColor),
      ),
      drawer: MyDrawer(),
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
      color: HexColor.fromHex(globals.drawerTileColor),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 100.0,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: HexColor.fromHex(globals.primaryColor),
              ),
            ),
          ),
          ListTile(
            title: Center(
                child: Text(
              'Home',
              style: TextStyle(
                color: Colors.white,
              ),
            )),
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          Divider(
            color: HexColor.fromHex('#F9F9F9'),
            height: 5,
            thickness: 2,
            indent: 15,
            endIndent: 15,
          ),
          ListTile(
            title: Center(
                child: Text(
              'Customize',
              style: TextStyle(
                color: Colors.white,
              ),
            )),
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => CustomizeScreen()));
            },
          ),
          Divider(
            color: HexColor.fromHex('#F9F9F9'),
            height: 5,
            thickness: 2,
            indent: 15,
            endIndent: 15,
          ),
          ListTile(
            title: Center(
                child: Text(
              'Shop',
              style: TextStyle(
                color: Colors.white,
              ),
            )),
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (context) => ShopScreen()));
            },
          ),
          Divider(
            color: HexColor.fromHex('#F9F9F9'),
            height: 5,
            thickness: 2,
            indent: 15,
            endIndent: 15,
          ),
          ListTile(
            title: Center(
                child: Text(
              'Analytics',
              style: TextStyle(
                color: Colors.white,
              ),
            )),
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => AnalyticsScreen()));
            },
          ),
          Divider(
            color: HexColor.fromHex('#F9F9F9'),
            height: 5,
            thickness: 2,
            indent: 15,
            endIndent: 15,
          ),
          ListTile(
            title: Center(
                child: Text(
              'Settings',
              style: TextStyle(
                color: Colors.white,
              ),
            )),
            onTap: () {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => SettingsScreen()));
            },
          ),
        ],
      ),
    ));
  }
}
