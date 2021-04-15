# CIS4030 Final Project
## Developed By <ins>Cameron Dixon</ins> and <ins>Giovanni Diamante</ins>
  
### Summary:
This is a mobile Flutter application that serves as a Pomodoro timer.
Users can set custom work session, break session, and long break session lengths. When completing a work session users earn currency which can be spent on custom themes to modify the look of their timer.  Purchases and timer settings are saved between sessions.

### Run Instructions:
1. Load project in Android Studio
2. Perform a "pub get" for the project
3. Load application on the Google Pixel 3a emulator.

### Limitations:
- Has only been tested on the Google Pixel 3a emulator
- Currently only supports colour themes and not image themes
- Settings currently do not affect the app
- No user login
- Graph does not contain monthly data

### Known Issues:
1. Timer always set to 00:00 when entering the home page.  When either start or reset is pressed the correct time is displayed
2. On app launch the first timer's work time is set to the default time instead of loading user preferences
- These two issues are believed to be due to the library used for the circular timer