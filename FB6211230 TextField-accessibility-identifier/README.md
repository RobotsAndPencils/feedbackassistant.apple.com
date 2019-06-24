# TextField accessibility identifier API and behavior are inconsistent with other Views

FB6211230

## Please provide a descriptive title for your feedback:
TextField accessibility identifier API and behavior are inconsistent with other Views

## Which area are you seeing an issue with?
SwiftUI Framework

## What type of feedback are you reporting?
Incorrect/Unexpected Behavior

## Description
Please describe the issue and what steps we can take to reproduce it:

Setting an accessibility identifier on a View such as a Button can be successfully done with code like the following:

```
Button(action: { /* ... */ }, label: { Text("Log In") })
    .accessibility(identifier: "login.primaryAction")
```

Doing the same with a TextField doesn't work, though:

```
TextField($viewModel.username)
    .accessibility(identifier: "login.username")
```

Full view hierarchy:
```
Application, pid: 65228, label: 'SwiftUI+XCUITest'
  Window (Main), {{0.0, 0.0}, {375.0, 812.0}}
    Other, {{0.0, 0.0}, {375.0, 812.0}}
      Other, {{0.0, 0.0}, {375.0, 812.0}}
        Other, {{0.0, 0.0}, {375.0, 812.0}}
          StaticText, {{16.0, 60.0}, {78.7, 21.0}}, label: 'Username'
          TextField, {{102.7, 60.0}, {256.3, 21.0}}
          StaticText, {{16.0, 93.3}, {73.7, 21.0}}, label: 'Password'
          TextField, {{97.7, 93.3}, {261.3, 21.0}}
          Button, {{164.3, 142.7}, {46.7, 21.0}}, identifier: 'login.primaryAction', label: 'Log In', Disabled
  Window, {{0.0, 0.0}, {375.0, 812.0}}
    Other, {{0.0, 0.0}, {375.0, 812.0}}
      Other, {{0.0, 0.0}, {375.0, 812.0}}
  Window, {{0.0, 0.0}, {375.0, 812.0}}
    Other, {{0.0, 0.0}, {375.0, 812.0}}
      Other, {{0.0, 0.0}, {375.0, 812.0}}
  Window, {{0.0, 0.0}, {375.0, 812.0}}
```

It's possible to work around this by also using the `accessibilityElement` modifier:

```
TextField($viewModel.username)
    .accessibilityElement()
    .accessibility(identifier: "login.username")
```

Full view hierarchy:
```
Application, pid: 65287, label: 'SwiftUI+XCUITest'
  Window (Main), {{0.0, 0.0}, {375.0, 812.0}}
    Other, {{0.0, 0.0}, {375.0, 812.0}}
      Other, {{0.0, 0.0}, {375.0, 812.0}}
        Other, {{0.0, 0.0}, {375.0, 812.0}}
          StaticText, {{16.0, 60.0}, {78.7, 21.0}}, label: 'Username'
          Other, {{102.7, 60.0}, {256.3, 21.0}}, identifier: 'login.username'
            TextField, {{102.7, 60.0}, {256.3, 21.0}}
          StaticText, {{16.0, 93.3}, {73.7, 21.0}}, label: 'Password'
          TextField, {{97.7, 93.3}, {261.3, 21.0}}
          Button, {{164.3, 142.7}, {46.7, 21.0}}, identifier: 'login.primaryAction', label: 'Log In', Disabled
  Window, {{0.0, 0.0}, {375.0, 812.0}}
    Other, {{0.0, 0.0}, {375.0, 812.0}}
      Other, {{0.0, 0.0}, {375.0, 812.0}}
  Window, {{0.0, 0.0}, {375.0, 812.0}}
    Other, {{0.0, 0.0}, {375.0, 812.0}}
      Other, {{0.0, 0.0}, {375.0, 812.0}}
  Window, {{0.0, 0.0}, {375.0, 812.0}}
```

Note that the identifier is set on an Other element which wraps the TextField element. Using this workaround means that you also need to change XCUITest code. For example, from this:

`let usernameField = application.textFields.matching(identifier: "login.username").firstMatch`

to this:

`let usernameField = application.otherElements.matching(identifier: "login.username").firstMatch`
