import 'package:flutter/material.dart';
import 'hexcolor.dart';
import 'globalvars.dart' as globals;
import 'main.dart';

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
      body: Container(
        child: ListView(
          children: [
            Card(
                child: Column(
              children: [],
            )),
            Card(
              child: Column(),
            ),
          ],
        ),
      ),
    );
  }
}
