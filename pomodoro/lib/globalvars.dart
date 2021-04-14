library pomodoro.globalbars;

import 'dart:collection';

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
  bool purchased;
  int price;
}

class featuredShopItem extends shopItem {
  String imageURL;

  featuredShopItem(String id, int pr, String img, bool purchased) {
    this.id = id;
    this.purchased = purchased;
    this.imageURL = img;
    this.price = pr;
  }

  Map toJson() => {
    'id': this.id,
    'price': this.price,
    'imageURL': this.imageURL,
    'purchased': this.purchased
  };
}

class combinationShopItem extends shopItem {
  String primaryColour;
  String secondaryColour;

  combinationShopItem (String id, int pr, String prim, String sec, bool purchased) {
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
    'purchased': this.purchased
  };

}

List<combinationShopItem> combinations = [
  new combinationShopItem("0", 500, "ECB528", "26A8A0", false),
  new combinationShopItem("1", 500, "EB5555", "26BC6B", false),
  new combinationShopItem("2", 500, "31A826", "F22BDE", false),
  new combinationShopItem("3", 500, "26A8A0", "F2EA2B", false),
];

List<featuredShopItem> items = [
  new featuredShopItem("4", 2500, 'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80', false),
  new featuredShopItem("5", 2200, 'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80', false),
  new featuredShopItem("6", 2350, 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80', false),
  new featuredShopItem("7", 2400, 'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80', false),
  new featuredShopItem("8", 2900, 'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80', false),
  new featuredShopItem("9", 2600, 'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80', false),
];

HashMap hashMap = new HashMap<String, shopItem>();

void populateMap() {
  int i = 0;
  for(; i < combinations.length; i++) {
    hashMap.putIfAbsent(i.toString(), () => combinations.elementAt(i));
  }

  for(int j = 0; j < items.length; j++) {
    hashMap.putIfAbsent((j + i).toString(), () => items.elementAt(j));
  }
}