# Buuk-Luuz

Buuk-Luuz is a Flutter application designed for Chama and savings group management across East Africa. It provides tools for member onboarding, contributions, loans, payments, meetings, and reporting while integrating cloud backend services for authentication and data storage.

## Key Features

- Chama group creation and membership management
- Contributions tracking and payment recording
- Loan requests and repayments
- Meeting scheduling and attendance management
- Member profile handling with ID uploads
- PDF reporting and printable statements
- Cross-platform support for mobile, web, desktop, and embedded platforms

## Technology Stack

- Flutter for UI and cross-platform app delivery
- Riverpod for state management
- GoRouter for navigation
- Supabase for backend, authentication, and database storage
- Firebase Messaging for push notifications
- Shared preferences and secure storage for local persistence
- Reactive Forms for form validation
- PDF generation via `pdf` and `printing`

## Repository Structure

- `lib/` - main application source
  - `core/` - theme, routing, utilities, and app-wide logic
  - `data/` - data sources, models, and repositories
  - `features/` - feature modules, including auth, chama, contributions, loans, meetings, members, payments, and reports
  - `shared/` - widgets, providers, and shared components
  - `layout/` - responsive and shell layouts
- `assets/` - icons and images
- `android/`, `ios/`, `linux/`, `macos/`, `windows/`, `web/` - platform-specific Flutter hosts

## Setup

1. Install Flutter: https://docs.flutter.dev/get-started/install
2. Configure your Supabase project and update `lib/main.dart`:

```dart
await Supabase.initialize(
  url: 'YOUR_SUPABASE_URL',
  anonKey: 'YOUR_SUPABASE_ANON_KEY',
);
```

3. Install dependencies:

```bash
default flutter pub get
```

4. Run the app:

```bash
flutter run
```

## Notes

- The app currently uses placeholder Supabase keys in `lib/main.dart`; replace them with your project credentials.
- Firebase Messaging is included for notifications; configure Firebase for your target platforms if using push notifications.
- This repository is intended for a Chama management product focused on East African savings groups.

## License

This project currently does not specify a license. Add one if needed.
