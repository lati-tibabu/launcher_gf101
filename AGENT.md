# Flutter System Launcher

This project is a minimal Flutter-based system launcher for Android.

## Features

- **System Launcher**: Configured as a Home screen replacement.
- **App Management**: Fetches all installed apps using `device_apps`.
- **State Management**: Uses `Riverpod` for efficient state handling.
- **Minimal Design**: Clean `GridView` UI for easy customization.

## Configuration

- `AndroidManifest.xml` updated with `HOME`, `DEFAULT`, and `LAUNCHER` intent filters.
- `QUERY_ALL_PACKAGES` permission included for Android 11+ compatibility.

## Tech Stack

- Flutter
- Riverpod (State Management)
- device_apps (Package Management)
- url_launcher (Opening Apps)

## Getting Started

To run this project:

1. Ensure Flutter is installed.
2. Connect an Android device or emulator.
3. Run `flutter run`.
4. When prompted, select "Flutter Launcher" as your Home app.
