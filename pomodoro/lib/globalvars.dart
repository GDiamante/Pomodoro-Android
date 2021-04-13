library pomodoro.globalbars;

// Colors
String primaryColor = '#B952E2';
String drawerTileColor = '#4D4D4D';
String offWhiteColor = '#EAEAEA';

// Notifications Settings
bool bannerNotifications = true;
bool lockNotifications = true;
bool centerNotifications = true;

// Misc Settings
bool soundEffects = true;
bool preventScreenLock = true;
bool vibrateOnSilent = true;

//Shop & currency
int shopCurrency = 0;

class featuredShopItem {
  String imageURL;
  int price;
  String id;

  featuredShopItem(int pr, String img) {
    this.imageURL = img;
    this.price = pr;
  }
}

class combinationShopItem {
  String primaryColour;
  String secondaryColour;
  int price;
  String id;

  combinationShopItem (int pr, String prim, String sec) {
    this.price = pr;
    this.primaryColour = prim;
    this.secondaryColour = sec;
  }
}

List<combinationShopItem> combinations = [
  new combinationShopItem(500, "ECB528", "26A8A0"),
  new combinationShopItem(500, "EB5555", "26BC6B"),
  new combinationShopItem(500, "31A826", "F22BDE"),
  new combinationShopItem(500, "26A8A0", "F2EA2B"),
];

List<featuredShopItem> items = [
  new featuredShopItem(2500, 'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80'),
  new featuredShopItem(2200, 'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80'),
  new featuredShopItem(2350, 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80'),
  new featuredShopItem(2400, 'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80'),
  new featuredShopItem(2900, 'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80'),
  new featuredShopItem(2600, 'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'),
];
