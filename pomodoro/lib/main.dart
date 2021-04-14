import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'globalvars.dart' as globals;
import 'hexcolor.dart';
import 'customtimer.dart' as timer;
import 'shop.dart';
import 'customize.dart';

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
      body: Container(
        child: timer.CustomTimer(),
      ),
    );
  }
}

class timerWarningAlert extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text("Hold On!"),
        content: Text("You must reset the timer before navigating away.  This will forfeit your reward for losing focus."),
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
    if (!timer.CustomTimer.newTimer) {
      return timerWarningAlert();
    }
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
