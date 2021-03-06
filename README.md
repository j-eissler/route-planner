# Route Planner (Readme WIP)

This cross-platform app aims to help users plan long routes with many stops. It provides an overview by displaying a Google Map with markers for all stops. It allows searching and adding new places all from within this app.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Google API Key
This app uses Google services which require an API key for billing. Templates are provided for the files that contain secrets. You need to remove '_template' from the filename. This was done to avoid pushing files with secrets to version control. Enter your own API key into the following files:
- [/android/app/src/main/AndroidManifest.xml](/android/app/src/main/AndroidManifest.xml)
- [/lib/auth/secrets.dart](/lib/auth/secrets.dart)

A guide on how to get an API key can be found [here](https://developers.google.com/maps/documentation/javascript/get-api-key).
