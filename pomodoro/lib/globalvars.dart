library pomodoro.globalbars;

import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'main.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

// Colors
String primaryColor = '#B952E2';
String secondaryColor = '#15CECE';
String drawerTileColor = '#4D4D4D';
String offWhiteColor = '#EAEAEA';

// Notifications Settings
bool bannerNotifications = true;
bool lockNotifications = true;
bool centerNotifications = true;

//Timer Settings
int workDuration = 5;
int breakDuration = 3;
int longBreakDuration = 8;
int roundsPerSession = 2; //Number of work sessions before long break

// Misc Settings
bool soundEffects = true;
bool preventScreenLock = true;
bool vibrateOnSilent = true;

//Shop & currency
int shopCurrency = 10000;

abstract class shopItem {
  String id;
  String productName;
  bool purchased;
  int price;
}

class featuredShopItem extends shopItem {
  String imageURL;

  featuredShopItem(String id, int pr, String img, bool purchased, String productName) {
    this.productName = productName;
    this.id = id;
    this.purchased = purchased;
    this.imageURL = img;
    this.price = pr;
  }

  Map toJson() => {
    'id': this.id,
    'price': this.price,
    'imageURL': this.imageURL,
    'purchased': this.purchased,
    'productName': this.productName
  };
}

class combinationShopItem extends shopItem {
  String primaryColour;
  String secondaryColour;

  combinationShopItem (String id, int pr, String prim, String sec, bool purchased, String productName) {
    this.productName = productName;
    this.id = id;
    this.price = pr;
    this.primaryColour = prim;
    this.secondaryColour = sec;
    this.purchased = purchased;
  }

  Map toJson() => {
    'id': this.id,
    'price': this.price,
    'primaryColour': this.primaryColour,
    'secondaryColour': this.secondaryColour,
    'purchased': this.purchased,
    'productName': this.productName
  };



}

List<combinationShopItem> combinations = [
  new combinationShopItem("C0", 500, "ECB528", "26A8A0", false, "Bright Orange/Dark Cyan"),
  new combinationShopItem("C1", 500, "EB5555", "26BC6B", false, "Soft Red/Lime Green"),
  new combinationShopItem("C2", 500, "31A826", "F22BDE", false, "Dark Lime Green/Bright Magenta"),
  new combinationShopItem("C3", 500, "26A8A0", "F2EA2B", false, "Dark Cyan/Bright Yellow"),
];

List<featuredShopItem> items = [
  new featuredShopItem("F0", 2500, 'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80', false, "Wedding photo"),
  new featuredShopItem("F1", 2200, 'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80', false, "Sunny Chromebook Walk"),
  new featuredShopItem("F2", 2350, 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80', false, "Beachside Chair"),
  new featuredShopItem("F3", 2400, 'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80', false, "Dusty Walk"),
  new featuredShopItem("F4", 2900, 'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80', false, "Foggy Mountain"),
  new featuredShopItem("F5", 2600, 'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80', false, "Canyons"),
];

HashMap shopItems = new HashMap<String, shopItem>();

HashMap purchasedItems = new HashMap<String, shopItem>();

void populateMap() {
  for(int i = 0; i < combinations.length; i++) {
    shopItems.putIfAbsent(combinations.elementAt(i).id, () => combinations.elementAt(i));
  }

  for(int j = 0; j < items.length; j++) {
    shopItems.putIfAbsent(items.elementAt(j).id, () => items.elementAt(j));
  }
}


String encodeSettings() {
  String ret = "";
  ret = '\"primaryColor\": ' + jsonEncode(primaryColor)
      + ',\"drawerTileColor\": ' + jsonEncode(drawerTileColor)
      + ',\"offWhiteColor\": ' + jsonEncode(offWhiteColor)
      + ',\"bannerNotifications\": ' + jsonEncode(bannerNotifications)
      + ',\"lockNotifications\": ' + jsonEncode(lockNotifications)
      + ',\"centerNotifications\": ' + jsonEncode(centerNotifications)
      + ',\"workDuration\": ' + jsonEncode(workDuration)
      + ',\"breakDuration\": ' + jsonEncode(breakDuration)
      + ',\"longBreakDuration\": ' + jsonEncode(longBreakDuration)
      + ',\"roundsPerSession\": ' + jsonEncode(roundsPerSession)
      + ',\"soundEffects\": ' + jsonEncode(soundEffects)
      + ',\"preventScreenLock\": ' + jsonEncode(preventScreenLock)
      + ',\"vibrateOnSilent\": ' + jsonEncode(vibrateOnSilent)
      + ',\"shopCurrency\": ' + jsonEncode(shopCurrency);
  return ret;
}

String fileName = "config.json";

void writeFile() {
  _write();
}

void updateGlobals(Map<String, dynamic> input) {
  print(input);
  primaryColor = input["primaryColor"];
  drawerTileColor = input["drawerTileColor"];
  offWhiteColor = input["offWhiteColor"];
  bannerNotifications = input["bannerNotifications"];
  lockNotifications = input["lockNotifications"];
  centerNotifications = input["centerNotifications"];
  workDuration = input["workDuration"];
  breakDuration = input["breakDuration"];
  longBreakDuration = input["longBreakDuration"];
  roundsPerSession = input["roundsPerSession"];
  soundEffects = input["soundEffects"];
  preventScreenLock = input["preventScreenLock"];
  shopCurrency = input["shopCurrency"];
  Map<String, dynamic> data = input["purchased"];
  for (String key in data.keys) {
    Map<String, dynamic> item = data[key];
    if (item["id"].toString().startsWith("C")) {
      combinationShopItem cItem = new combinationShopItem(key, item["price"], item["primaryColour"], item["secondaryColour"], item["purchased"], item["productName"]);
      purchasedItems[key] = cItem;
      (shopItems[key] as combinationShopItem).purchased = cItem.purchased;
    } else {
      featuredShopItem fItem = new featuredShopItem(key, item["price"], item["imageURL"], item["purchased"], item["productName"]);
      purchasedItems[key] = fItem;
      (shopItems[key] as featuredShopItem).purchased = fItem.purchased;
    }
  }
}

void readFile(_HomePageState) {
  var configFuture = _read();
  configFuture.then((config) {
    Map<String, dynamic> configMap = jsonDecode(config);
    updateGlobals(configMap);
  });
}

_write() async {
  final directory = await path_provider.getApplicationDocumentsDirectory();
  String configString = "{" + encodeSettings() + ', \"purchased\": ' + jsonEncode(purchasedItems) + "}";
  final File file = File('${directory.path}/config.json');
  await file.writeAsString(configString);
  return directory.path;
}

Future<String> _read() async {
  String config;
  try {
    final Directory directory = await path_provider.getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/config.json');
    config = await file.readAsString();
  } catch (e) {
    print("Couldn't read file");
  }
  return config;
}
