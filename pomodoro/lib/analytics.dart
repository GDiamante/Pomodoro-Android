import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro/hexcolor.dart';
import 'globalvars.dart' as globals;

class statsDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      color: HexColor.fromHex(globals.offWhiteColor),
      height: 5,
      thickness: 3,
      indent: 15,
      endIndent: 15,
    );
  }
}

class statRow extends StatelessWidget {
  String stateName;
  String stat;

  statRow(String stateName, String stat) {
    this.stateName = stateName;
    this.stat = stat;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Text(
              stateName,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              stat,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class StatsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(.0),
          child: new Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Text(
                    "Pomodoro Statistics:",
                    style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                statRow("Total Sessions:", globals.allTimeSessions.toString()),
                statsDivider(),
                statRow("Total Work Sessions:", globals.allTimeWorkSessions.toString()),
                statsDivider(),
                statRow("Total Break Sessions:", globals.allTimeBreakSessions.toString()),
                statsDivider(),
                statRow("Average Monthly Sessions:", globals.allTimeSessions.toString()),
              ]
          ),
        ),
      ),
    );
  }
}

class AnalyticsChart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AnalyticsChartState();
}

class AnalyticsChartState extends State<AnalyticsChart> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        margin: EdgeInsets.all(10),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: Colors.white,
        child: BarChart(
          BarChartData(
            axisTitleData: FlAxisTitleData(
                topTitle: AxisTitle(
                  titleText: "2021 Pomodoro\'s",
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
            ),
            alignment: BarChartAlignment.spaceAround,
            maxY: 16,
            barTouchData: BarTouchData(
              enabled: false,
              touchTooltipData: BarTouchTooltipData(
                tooltipBgColor: Colors.transparent,
                tooltipPadding: const EdgeInsets.all(0),
                tooltipMargin: 8,
                getTooltipItem: (
                    BarChartGroupData group,
                    int groupIndex,
                    BarChartRodData rod,
                    int rodIndex,
                    ) {
                  return BarTooltipItem(
                    rod.y.round().toString(),
                    TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: SideTitles(
                showTitles: true,
                getTextStyles: (value) => const TextStyle(
                    color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 14),
                margin: 20,
                getTitles: (double value) {
                  switch (value.toInt()) {
                    case 1:
                      return 'Jan';
                    case 2:
                      return 'Feb';
                    case 3:
                      return 'Mar';
                    case 4:
                      return 'Apr';
                    case 5:
                      return 'May';
                    case 6:
                      return 'Jun';
                    case 7:
                      return 'Jul';
                    case 8:
                      return 'Aug';
                    case 9:
                      return 'Sep';
                    case 10:
                      return 'Oct';
                    case 11:
                      return 'Nov';
                    case 12:
                      return 'Dec';
                    default:
                      return '';
                  }
                },
              ),
              leftTitles: SideTitles(showTitles: false),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            barGroups: [
              createDataItem(1, 0),
              createDataItem(2, 0),
              createDataItem(3, 0),
              createDataItem(4, globals.allTimeSessions.toDouble()),
              createDataItem(5, 0),
              createDataItem(6, 0),
              createDataItem(7, 0),
              createDataItem(8, 0),
              createDataItem(9, 0),
              createDataItem(10, 0),
              createDataItem(11, 0),
              createDataItem(12, 0),
            ],
          ),
        ),
      ),
    );
  }
}

BarChartGroupData createDataItem(int axis, double height) {
  return BarChartGroupData(
    x: axis,
    barRods: [
      BarChartRodData(y: height, colors: [HexColor.fromHex(globals.primaryColor), HexColor.fromHex(globals.secondaryColor)])
    ],
    showingTooltipIndicators: [0],
  );
}

