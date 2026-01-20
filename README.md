# Nikko Digital Ink

Quick Test


What?
- An app that takes drawing strokes and outputs digital equivlant using Google's ML Kit's Digital Ink Japanese language model. 

Why?
- To learn about digital ink ahead of a meeting
- Why Nikko? 
    - Will explain in person ;) Its a lovely city in the Japanese mountains!

How?
- A tiny <20MB model is downloaded on the user's device. In this case we specifically target Japanese langauge because that's the audience this particualar exmaple is built for.

- Tons of optimization is still needed to get it to work well enough so it does not think you're writing random stuff. You can see those in the `/utils/` directory.
    - Of course there is still room 

```
App Start → Check Model Status → Already Downloaded? 
    ↓                              ↓
    NO                             YES
    ↓                              ↓
Download Model                 Show "Ready"
    ↓                              ↓
Show "Ready"                   Enable Button
    ↓                              ↓
Enable Button              Navigate to Home
    ↓
Navigate to Home
```

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
