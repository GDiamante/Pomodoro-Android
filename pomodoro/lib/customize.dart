import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'hexcolor.dart';
import 'globalvars.dart' as globals;
import 'main.dart';

class CustomizeScreen extends StatefulWidget {
  @override
  _CustomizeScreenState createState() => _CustomizeScreenState();
}

class _CustomizeScreenState extends State<CustomizeScreen> {
  @override
  Widget build(BuildContext ctxt) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Customize"),
        elevation: 0,
        backgroundColor: HexColor.fromHex(globals.primaryColor),
      ),
      drawer: MyDrawer(),
      body: Container(
        color: HexColor.fromHex(globals.offWhiteColor),
        child: ListView(
          children: [
            Card(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(ctxt).size.height * 0.03,
                    left: MediaQuery.of(ctxt).size.width * 0.02,
                    right: MediaQuery.of(ctxt).size.width * 0.02,
                    bottom: MediaQuery.of(ctxt).size.height * 0.03),
                color: Colors.white,
                child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(ctxt).size.height * 0.03,
                        left: MediaQuery.of(ctxt).size.width * 0.02,
                        right: MediaQuery.of(ctxt).size.width * 0.02,
                        bottom: MediaQuery.of(ctxt).size.height * 0.03),
                    child: Column(
                      children: [ColorDropDown(css: this)],
                    ))),
            Card(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(ctxt).size.height * 0.03,
                  left: MediaQuery.of(ctxt).size.width * 0.02,
                  right: MediaQuery.of(ctxt).size.width * 0.02,
                  bottom: MediaQuery.of(ctxt).size.height * 0.03),
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(ctxt).size.width * 0.02,
                    right: MediaQuery.of(ctxt).size.width * 0.02,
                    bottom: MediaQuery.of(ctxt).size.height * 0.03),
                child: Column(
                children: [TimeValues()],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ColorDropDown extends StatefulWidget {
  final _CustomizeScreenState css;
  const ColorDropDown({Key key, @required this.css}) : super(key: key);

  @override
  _ColorDropDownState createState() => _ColorDropDownState();
}

class _ColorDropDownState extends State<ColorDropDown> {
  globals.shopItem dropdownValue = globals.purchasedItems[globals.currentThemeId];

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
        decoration: InputDecoration(
          labelText: "Color Scheme",
          labelStyle: Theme.of(context)
              .primaryTextTheme
              .caption
              .copyWith(color: Colors.black, fontSize: 22),
          border: const OutlineInputBorder(),
        ),
        child: DropdownButtonHideUnderline(
            child: DropdownButton<globals.shopItem>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_drop_down),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: HexColor.fromHex(globals.secondaryColor), fontSize: 18),
          onChanged: (globals.shopItem newValue) {
            setState(() {
              dropdownValue = newValue;
              globals.currentThemeId = newValue.id;
              if (newValue is globals.combinationShopItem) {
                globals.primaryColor = (newValue as globals.combinationShopItem).primaryColour;
                globals.secondaryColor = (newValue as globals.combinationShopItem).secondaryColour;
              }
              globals.writeFile();
              widget.css.setState(() {});
            });
          },
          items: globals.purchasedItems
              .map((description, value) {
                return MapEntry(
                    description,
                    DropdownMenuItem<globals.shopItem>(
                      value: value,
                      child: Text(value.productName),
                    ));
              })
              .values
              .toList(),
        )));
  }
}

class TimeValues extends StatefulWidget {
  @override
  _TimeValuesState createState() => _TimeValuesState();
}

class _TimeValuesState extends State<TimeValues> {
  TextEditingController _workController;
  TextEditingController _shortController;
  TextEditingController _longController;
  TextEditingController _sessionController;

  void initState() {
    super.initState();
    _workController = new TextEditingController(text: globals.workDuration.toString());
    _shortController = new TextEditingController(text: globals.breakDuration.toString());
    _longController = new TextEditingController(text: globals.longBreakDuration.toString());
    _sessionController = new TextEditingController(text: globals.roundsPerSession.toString());
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: const EdgeInsets.all(40.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new TextField(
              controller: _workController,
              decoration: new InputDecoration(labelText: "Focus Length (Seconds)"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (text) {
                setState(() {
                  text != "" ? globals.workDuration = int.parse(text) : globals.workDuration = 0;
                });
                globals.writeFile();
              },
            ),
            new TextField(
              controller: _shortController,
              decoration: new InputDecoration(labelText: "Short Break Length (Seconds)"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (text) {
                setState(() {
                  text != "" ? globals.breakDuration = int.parse(text) : globals.breakDuration = 0;
                });
                globals.writeFile();
              },
            ),
            new TextField(
              controller: _longController,
              decoration: new InputDecoration(labelText: "Long Break Length (Seconds)"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (text) {
                setState(() {
                  text != "" ? globals.longBreakDuration = int.parse(text) : globals.longBreakDuration = 0;
                });
                globals.writeFile();
              },
            ),
            new TextField(
              controller: _sessionController,
              decoration: new InputDecoration(labelText: "Sessions Per Round(Long Break)"),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              onChanged: (text) {
                setState(() {
                  text != "" ? globals.roundsPerSession = int.parse(text) : globals.roundsPerSession = 0;
                });
                globals.writeFile();
              },
            ),
          ],
        ));
  }
}
