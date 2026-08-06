# CodeVoice Vision

CodeVoice Vision is a Flutter app for local-first visual capture and sync.
It is designed around four isolated layers:

- Camera management
- On-device vision processing
- Local storage and database persistence
- Cloud sync through Google Apps Script

The codebase is organized as a modular Flutter app with real camera capture, on-device vision processing, local storage, and optional Apps Script sync wiring.

## What It Includes

- Dashboard for system status and recent capture summary
- Camera manager for selecting a source and creating captures
- Vision engine screen for structured AI result output
- Gallery for local captures and metadata
- Drift-backed local database
- Sync manager for queueing and pushing capture records
- Settings for sync, defaults, and capture note templates
- Device manager and supporting utility screens

## Project Structure

- lib/camera_manager - camera source discovery, connection, and capture flow
- lib/vision_engine - structured analysis output for each image
- lib/local_storage - image and thumbnail storage on disk
- lib/database - Drift database and repository layer
- lib/sync - Apps Script sync client and queue manager
- lib/gallery - capture history and stored metadata
- lib/settings - persisted app settings
- lib/home - dashboard and system overview
- lib/shared - reusable UI widgets

## Requirements

- Flutter SDK 3.11 or newer
- Dart SDK that ships with the matching Flutter release
- Android Studio, VS Code, or another Flutter-compatible editor
- Android device or emulator for the main target platform

## Setup

From the project root:

`ash
flutter pub get
`

If you change Drift tables or generated data models, regenerate code with:

`ash
flutter pub run build_runner build --delete-conflicting-outputs
`

## How To Run

Run the app on an available device or emulator:

`ash
flutter run
`

If you want to target a specific device, list devices first:

`ash
flutter devices
`

Then run against a chosen device id:

`ash
flutter run -d <device_id>
`

## Useful Commands

`ash
flutter analyze
flutter test
flutter clean
`

## Notes

- Sync requires a configured Apps Script endpoint to upload data.
- Captures are stored locally first, then queued for sync.
- The project is intentionally modular so native camera, OCR, barcode, and cloud implementations can be added later.
