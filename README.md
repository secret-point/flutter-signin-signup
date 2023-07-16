# soultrain

A Flutter home task challenge.

## Getting Started

This application is written in flutter and displays a simple user list fetched from backend written in Express.js with sign up and sign in features

## How to Use

**Step 1:**

Download or clone this repo by using the link below:

```
https://github.com/zubairehman/flutter-boilerplate-project.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies:

```
flutter pub get
```

**Step 3:**

This project uses `inject` library that works with code generation, execute the following command to generate files:

```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

or watch command in order to keep the source code synced automatically:

```
flutter packages pub run build_runner watch
```

## Project Features:

- Express.js(Backend)
- Database (MongoDB)
- Sign in
- Sign up
- Validation
- Encryption
- User Notifications

### Folder Structure

Here is the core folder structure which flutter provides.

```
soultrain/
|- android
|- build
|- ios
|- lib
|- test
```

Here is the folder structure we have been using in this project

```
lib/
|- components/
|- constants/
|- ui/
|- utils/
|- main.dart
```

```
1- components - Contains the common widgets that are shared across multiple screens.

2- constants - All the application level constants are defined in this directory with-in their respective files.

3- ui - This directory contains all the ui of your application. Each screen is located in a separate folder making it easy to combine group of files related to that particular screen. All the screen specific widgets will be placed in `components` directory

4- Contains the common file(s) and utilities used in a project

5- main.dart - This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.
```

### Constants

This directory contains all the application level constants. A separate file is created for each type as shown in example below:

```
constants/
|- constants.dart
```

### UI

This directory contains all the ui of your application. Each screen is located in a separate folder making it easy to combine group of files related to that particular screen. All the screen specific widgets will be placed in `components` directory as shown in the example below:

```
ui/
|- login
   |- login_screen.dart
   |- components
      |- login_form.dart
      |- login_screen_top_image.dart
```

### Utils

Contains the common file(s) and utilities used in a project. The folder structure is as follows:

```
utils/
|- utility.dart
|- responsive.dart
```

### components

Contains the common widgets that are shared across multiple screens. For example, background.dart etc.

```
widgets/
|- already_have_an_account_acheck.dart
|- background.dart
```

### Main

This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, title, orientation etc.

```dart
import 'package:flutter/material.dart';
import 'package:soultrain/ui/welcome/welcome_screen.dart';
import 'package:soultrain/constants/constants.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Auth',
      theme: ThemeData(
          primaryColor: Constants.kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: Constants.kPrimaryColor,
              shape: const StadiumBorder(),
              maximumSize: const Size(double.infinity, 56),
              minimumSize: const Size(double.infinity, 56),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Constants.kPrimaryLightColor,
            iconColor: Constants.kPrimaryColor,
            prefixIconColor: Constants.kPrimaryColor,
            contentPadding: EdgeInsets.symmetric(
                horizontal: Constants.defaultPadding,
                vertical: Constants.defaultPadding),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide.none,
            ),
          )),
      home: const WelcomeScreen(),
    );
  }
}

```

## Conclusion

Thanks for viewing my application. 🙏
I'd be happy to hear your thoughts and feedback. 🙂
