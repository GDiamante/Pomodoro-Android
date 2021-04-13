import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'globalvars.dart' as globals;
import 'customtimer.dart' as timer;

void main() {
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
      body: Container(
        child: timer.CustomTimer(),
      ),
    );
  }
}

final List<Widget> gridTiles = globals.combinations.map((comb) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
    ),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Container(
          color: HexColor.fromHex(comb.primaryColour),
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
                          color: HexColor.fromHex(comb.secondaryColour),
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
                      comb.price.toString() + ' points',
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
  );
}).toList();

final List<Widget> imageSliders = globals.items
    .map((item) => Container(
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
                        fit: BoxFit.cover, image: NetworkImage(item.imageURL))),
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
                        item.price.toString() + ' points',
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
        ))
    .toList();

class ShopScreen extends StatelessWidget {
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
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
                    items: imageSliders,
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
                          children: gridTiles,
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

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
