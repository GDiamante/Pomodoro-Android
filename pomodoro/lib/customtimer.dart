import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'globalvars.dart' as globals;
import 'hexcolor.dart';

class CustomTimer extends StatefulWidget {
  static bool timerRunning = false;
  static bool newTimer = true;

  @override
  _CustomTimerState createState() => _CustomTimerState();
}

class _CustomTimerState extends State<CustomTimer> {
  CountDownController _controller;
  int _duration;
  bool isWorkSession;
  int timerNumber;

  void initState() {
    super.initState();
    _duration = globals.workDuration;
    isWorkSession = true;
    timerNumber = 1;
    _controller = CountDownController();
    CustomTimer.newTimer = true;
    CustomTimer.timerRunning = false;
  }

  void timerComplete() {
    globals.shopCurrency += _duration;
    setState(() {
      timerNumber++;
      isWorkSession = !isWorkSession;

      //Determine length of time for new timer
      if (timerNumber % 2 == 0 && timerNumber == globals.roundsPerSession + 1) {
        _duration = globals.longBreakDuration;
      } else if (timerNumber % 2 == 0) {
        _duration = globals.breakDuration;
      } else if (timerNumber % 2 == 1) {
        _duration = globals.workDuration;
      }
    });

    _controller.start();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor.fromHex(globals.primaryColor),
      body: Column(
          children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).size.height * 0.17, 0, 0)),
          Text(
            isWorkSession ? "Work Session" : "Break Session",
            textAlign: TextAlign.center,
            textScaleFactor: 3,
            style: TextStyle(color: HexColor.fromHex(globals.offWhiteColor)),
          )
        ]),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          CircularCountDownTimer(
            // Countdown duration in Seconds.
            duration: _duration,

            // Countdown initial elapsed Duration in Seconds.
            initialDuration: 0,

            // Controls (i.e Start, Pause, Resume, Restart) the Countdown Timer.
            controller: _controller,

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
            autoStart: false,

            // This Callback will execute when the Countdown Starts.
            onStart: () {
            },

            // This Callback will execute when the Countdown Ends.
            onComplete: () {
              timerComplete();
            },
          )
        ]),
            CustomTimer.newTimer
            ? _button(
                title: "Start",
                onPressed: () => {
                      setState(() {
                        CustomTimer.timerRunning = true;
                      }),
                      setState(() {
                        CustomTimer.newTimer = false;
                      }),
                      _controller.start()
                    })
            : CustomTimer.timerRunning
                ? _button(
                    title: "Pause",
                    onPressed: () => {
                          setState(() {
                            CustomTimer.timerRunning = false;
                          }),
                          _controller.pause()
                        })
                : _button(
                    title: "Resume",
                    onPressed: () => {
                          setState(() {
                            CustomTimer.timerRunning = true;
                          }),
                          _controller.resume()
                        }),
        _button(
            title: "Reset",
            onPressed: () => {
                  setState(() {
                    CustomTimer.timerRunning = !CustomTimer.timerRunning;
                    CustomTimer.newTimer = true;
                  }),
                  _controller.start(),
                  _controller.pause(),
                }),
      ]),
    );
  }

  _button({@required String title, VoidCallback onPressed}) {
    return Container(
        margin: EdgeInsets.only(bottom: 13),
      child: ConstrainedBox(constraints: BoxConstraints.tightFor(width: MediaQuery.of(context).size.width * 0.4, height: MediaQuery.of(context).size.height * 0.05),
      child: ElevatedButton(
            child: Text(
              title,
              style: TextStyle(color: HexColor.fromHex(globals.offWhiteColor)),
            ),
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              primary: Colors.purple,
            ),
        )));
  }
}
