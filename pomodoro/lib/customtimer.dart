import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'globalvars.dart' as globals;
import 'hexcolor.dart';

class CustomTimer extends StatefulWidget {
  static bool timerRunning = false;
  static bool newTimer = true;
  final Function(dynamic)
      updateParent; //Updates isWorkSession bool variable for parent

  CustomTimer({Key key, @required this.updateParent}) : super(key: key);

  @override
  CustomTimerState createState() => CustomTimerState();
}

class CustomTimerState extends State<CustomTimer> {
  int _duration;
  bool isWorkSession;
  int timerNumber;
  CountDownController _workController;
  CountDownController _breakController;

  void initState() {
    super.initState();
    isWorkSession = true;
    timerNumber = 1;
    _duration = globals.workDuration;
    _workController = CountDownController();
    _breakController = CountDownController();
    CustomTimer.newTimer = true;
    CustomTimer.timerRunning = false;
  }

  void timerComplete() {
    if (isWorkSession) {
      globals.shopCurrency += _duration;
    }
    this.setState(() {
      timerNumber++;
      globals.allTimeSessions++;
      isWorkSession ? globals.allTimeWorkSessions++ : globals.allTimeBreakSessions++;
      isWorkSession = timerNumber % 2 == 1;
      widget.updateParent(isWorkSession);

      //Determine length of time for next timer
      if (!isWorkSession && timerNumber % (globals.roundsPerSession * 2) == 0) {
        _duration = globals.longBreakDuration;
      } else if (!isWorkSession) {
        _duration = globals.breakDuration;
      } else if (isWorkSession) {
        _duration = globals.workDuration;
      }
    });
    globals.writeFile();
  }

  @override
  Widget build(BuildContext context) {
    //Need two timers to to ensure state updates
    CircularCountDownTimer _workTimer(int workLength) {
      return new CircularCountDownTimer(
        // Countdown duration in Seconds.
        duration: _duration,

        // Countdown initial elapsed Duration in Seconds.
        initialDuration: 0,

        // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
        controller: _workController,

        // Width of the Countdown Widget.
        width: MediaQuery.of(context).size.width / 2,

        // Height of the Countdown Widget.
        height: MediaQuery.of(context).size.height / 2,

        // Ring Color for Countdown Widget.
        ringColor: HexColor.fromHex(globals.primaryColor),

        // Ring Gradient for Countdown Widget.
        ringGradient: null,

        // Filling Color for Countdown Widget.
        fillColor: HexColor.fromHex(globals.offWhiteColor),

        // Filling Gradient for Countdown Widget.
        fillGradient: null,

        // Background Color for Countdown Widget.
        backgroundColor: HexColor.fromHex(globals.primaryColor),

        // Background Gradient for Countdown Widget.
        backgroundGradient: null,

        // Border Thickness of the Countdown Ring.
        strokeWidth: 5.0,

        // Begin and end contours with a flat edge and no extension.
        strokeCap: StrokeCap.square,

        // Text Style for Countdown Text.
        textStyle: TextStyle(
            fontSize: 33.0,
            color: HexColor.fromHex(globals.offWhiteColor),
            fontWeight: FontWeight.bold),

        // Format for the Countdown Text.
        textFormat: CountdownTextFormat.MM_SS,

        // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
        isReverse: true,

        // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
        isReverseAnimation: true,

        // Handles visibility of the Countdown Text.
        isTimerTextShown: true,

        // Handles the timer start.
        autoStart: timerNumber == 1 ? false : true,
        //Start automatically after a break

        // This Callback will execute when the Countdown Starts.
        onStart: () {},

        // This Callback will execute when the Countdown Ends.
        onComplete: () {
          timerComplete();
        },
      );
    }

    CircularCountDownTimer _breakTimer(int breakLength) {
      return new CircularCountDownTimer(
        // Countdown duration in Seconds.
        duration: breakLength,

        // Countdown initial elapsed Duration in Seconds.
        initialDuration: 0,

        // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
        controller: _breakController,

        // Width of the Countdown Widget.
        width: MediaQuery.of(context).size.width / 2,

        // Height of the Countdown Widget.
        height: MediaQuery.of(context).size.height / 2,

        // Ring Color for Countdown Widget.
        ringColor: HexColor.fromHex(globals.secondaryColor),

        // Ring Gradient for Countdown Widget.
        ringGradient: null,

        // Filling Color for Countdown Widget.
        fillColor: HexColor.fromHex(globals.offWhiteColor),

        // Filling Gradient for Countdown Widget.
        fillGradient: null,

        // Background Color for Countdown Widget.
        backgroundColor: HexColor.fromHex(globals.secondaryColor),

        // Background Gradient for Countdown Widget.
        backgroundGradient: null,

        // Border Thickness of the Countdown Ring.
        strokeWidth: 5.0,

        // Begin and end contours with a flat edge and no extension.
        strokeCap: StrokeCap.square,

        // Text Style for Countdown Text.
        textStyle: TextStyle(
            fontSize: 33.0,
            color: HexColor.fromHex(globals.offWhiteColor),
            fontWeight: FontWeight.bold),

        // Format for the Countdown Text.
        textFormat: CountdownTextFormat.MM_SS,

        // Handles Countdown Timer (true for Reverse Countdown (max to 0), false for Forward Countdown (0 to max)).
        isReverse: true,

        // Handles Animation Direction (true for Reverse Animation, false for Forward Animation).
        isReverseAnimation: true,

        // Handles visibility of the Countdown Text.
        isTimerTextShown: true,

        // Handles the timer start.
        autoStart: true,

        // This Callback will execute when the Countdown Starts.
        onStart: () {},

        // This Callback will execute when the Countdown Ends.
        onComplete: () {
          timerComplete();
        },
      );
    }

    _button({@required String title, VoidCallback onPressed}) {
      Color bgColor = Colors.blueGrey;
      if (title == "Start" || title == "Resume") {
        bgColor = Colors.green;
      } else if (title == "Reset") {
        bgColor = Colors.red;
      } else if (title == "Pause") {
        bgColor = Colors.orange;
      }

      return Container(
          margin: EdgeInsets.only(bottom: 13),
          child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height * 0.05),
              child: ElevatedButton(
                child: Text(
                  title,
                  style:
                  TextStyle(color: HexColor.fromHex(globals.offWhiteColor)),
                ),
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  primary: bgColor,
                ),
              )));
    }

    return Scaffold(
      backgroundColor: isWorkSession
          ? HexColor.fromHex(globals.primaryColor)
          : HexColor.fromHex(globals.secondaryColor),
      body: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            isWorkSession ? "Work Session" : "Break Session", //Title Text
            textAlign: TextAlign.center,
            textScaleFactor: 3,
            style: TextStyle(color: HexColor.fromHex(globals.offWhiteColor)),
          )
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          //Timer Display
          Visibility(visible: isWorkSession, child: _workTimer(_duration)),
          Visibility(visible: !isWorkSession, child: _breakTimer(_duration))
        ]),
        CustomTimer.newTimer //Control Buttons change based on timer state
            ? _button(
                title: "Start",
                onPressed: () => {
                      setState(() {
                        CustomTimer.timerRunning = true;
                      }),
                      setState(() {
                        CustomTimer.newTimer = false;
                      }),
                      isWorkSession
                          ? _workController.start()
                          : _breakController.start()
                    })
            : CustomTimer.timerRunning
                ? _button(
                    title: "Pause",
                    onPressed: () => {
                          setState(() {
                            CustomTimer.timerRunning = false;
                          }),
                          isWorkSession
                              ? _workController.pause()
                              : _breakController.pause()
                        })
                : _button(
                    title: "Resume",
                    onPressed: () => {
                          setState(() {
                            CustomTimer.timerRunning = true;
                          }),
                          isWorkSession
                              ? _workController.resume()
                              : _breakController.resume()
                        }),
        _button(
            title: "Reset",
            onPressed: () => {
                  setState(() {
                    CustomTimer.timerRunning = !CustomTimer.timerRunning;
                    CustomTimer.newTimer = true;
                  }),
                  isWorkSession
                      ? _workController.start()
                      : _breakController.start(),
                  isWorkSession
                      ? _workController.pause()
                      : _breakController.pause(),
                }),
        Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02),
                child: IntrinsicHeight(
                    child: Row(
                  children: [
                    Column(children: [
                      Container(
                          color: HexColor.fromHex(globals.offWhiteColor),
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.05,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.05),
                          width: MediaQuery.of(context).size.width / 2,
                          child: Text(
                              "Work Session\n" +
                                  // ((timerNumber % (globals.roundsPerSession * 2))/2).ceil()
                                  ((((timerNumber - 1) % (globals.roundsPerSession * 2)) + 1)/2).ceil()
                                      .toString() +
                                  "/" +
                                  globals.roundsPerSession.toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16)))
                    ]),
                    VerticalDivider(
                        thickness: 3, width: 3, color: Colors.black),
                    Column(children: [
                      Container(
                          color: HexColor.fromHex(globals.offWhiteColor),
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.05,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.05),
                          width: MediaQuery.of(context).size.width / 2 - 3,
                          child: Text(
                              "Total Session\n" +
                                  (((timerNumber - 1) % (globals.roundsPerSession * 2)) + 1)
                                      .toString() +
                                  "/" +
                                  (globals.roundsPerSession * 2).toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16)))
                    ])
                  ],
                ))))
      ]),
    );
  }
}
