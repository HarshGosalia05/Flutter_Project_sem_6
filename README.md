# GLS Students

GLS Students is a Flutter student dashboard app with login, registration, profile management, courses, tests, results, progress tracking, files, and events screens.

## Features

- User registration and login
- Persistent login state with `shared_preferences`
- Profile page with logout flow
- Dashboard with navigation to courses, tests, results, and progress
- Course detail views and related content pages
- Local user storage for auth data
- Web-safe fallback storage so the app can run without the sqflite web worker script

## Database Behavior

The app now uses two storage paths:

- Native desktop/mobile: SQLite via `sqflite_common_ffi` and `sqflite`
- Web: a lightweight `SharedPreferences`-backed user store

This avoids the `databaseFactory not initialized` and missing `sqflite_sw.js` web worker errors.

## Project Structure

- `lib/main.dart` - app entry point, login bootstrap, and home navigation shell
- `lib/login_page.dart` - login screen and authentication flow
- `lib/register_page.dart` - registration screen and user creation flow
- `lib/ProfilePage.dart` - profile page and logout handling
- `lib/database_helper.dart` - platform-specific database helper facade
- `lib/database_helper_native.dart` - SQLite implementation for native targets
- `lib/database_helper_web.dart` - web storage implementation
- `test/widget_test.dart` - smoke test that verifies the app builds

## Prerequisites

- Flutter SDK 3.10 or newer
- Dart SDK matching the Flutter channel
- Android Studio, VS Code, or another Flutter-compatible IDE

## Setup

1. Clone the repository.
2. Open the project folder in your editor.
3. Run `flutter pub get`.
4. Run `flutter test` to verify the app boots.
5. Run `flutter run` for the default platform or `flutter run -d chrome` for web.

## Useful Commands

```bash
flutter pub get
flutter test
flutter analyze
flutter run
flutter run -d chrome
```

## Notes

- The app keeps the login session in `shared_preferences` using the `isLoggedIn` flag.
- Registration should return to the login page after saving a new account.
- The web build no longer requires a separate sqflite worker asset.
- Analyzer output still contains several existing style/info warnings in the older page files, but the app and tests run successfully.

## Testing

The current widget smoke test checks that the app builds successfully.

## License

No license has been specified for this repository.
