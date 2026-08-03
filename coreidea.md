CodeVoice Vision
Version 1.0 – Vision Platform

Purpose

A standalone Android application that can connect to multiple camera sources, perform on-device AI vision processing, store images locally, and synchronize images and metadata to Google Drive and Google Sheets through Google Apps Script.

This application is independent and can later become one module inside CodeVoice Companion.

Overall Architecture
                    CodeVoice Vision

                    Android Application

                           │

        ┌──────────────────┼──────────────────┐
        │                  │                  │
        │                  │                  │
 Camera Manager      Vision Engine      Sync Manager
        │                  │                  │
        │                  │                  │
        └──────────────┬───┴──────────────────┘
                       │
                 Local Database
                     (Drift)
                       │
                Local Image Storage
                       │
             Google Apps Script API
                │                 │
                │                 │
          Google Drive      Google Sheets
Design Philosophy

The application is divided into four major systems.

Camera Layer
AI Vision Layer
Local Data Layer
Cloud Synchronization Layer

Every layer has one responsibility.

1. Camera Layer

The Camera Layer is responsible only for communicating with cameras.

It never performs AI.

It never uploads files.

It never stores metadata.

Its only responsibility is capturing images.

Camera Manager

Supported Camera Types

Phone Rear Camera

Phone Front Camera

ESP32 Camera

USB Webcam

IP Camera (Future)

Smart Glass Camera (Future)

Wearable Camera (Future)
Responsibilities

Device Discovery

Camera Connection

Device Health

Camera Preview

Image Capture

Camera Configuration

Camera Switching

Device Information

Camera Settings

Resolution

FPS

Orientation

Image Quality

Flash

Zoom

Focus

Mirror

Rotation

Camera Interface

Every camera should behave identically.

Connect()

Disconnect()

Capture()

StartPreview()

StopPreview()

Settings()

DeviceInfo()

Therefore the Vision Engine never needs to know whether the image came from

Phone
ESP32
USB Camera
Glasses
2. Vision Engine

This is the AI system.

It receives an image from the Camera Manager.

It returns structured information.

Image Pipeline
Image

↓

Preprocessing

↓

Face Detection

↓

Object Detection

↓

OCR

↓

QR Detection

↓

Image Analysis Result
AI Modules
Face Detection

MediaPipe Face Detector

Output

Face Count

Bounding Boxes

Confidence
Face Recognition

MobileFaceNet

(Currently Disabled)

Future Feature

Object Detection

YOLO

Output

Detected Objects

Confidence

Coordinates
OCR

PaddleOCR

Output

Extracted Text
QR Detection

ML Kit Barcode

Output

QR Content

Barcode Content
Future Modules

Pose Detection

Hand Detection

Scene Understanding

Visual Question Answering

Vision Result Object

Every image produces one result.

Example

{
  "imageId":"IMG001",

  "timestamp":"2026-08-03",

  "camera":"Phone Rear",

  "faces":2,

  "objects":[
      "Laptop",
      "Bottle"
  ],

  "ocr":"Invoice Number 204",

  "qr":"https://example.com",

  "processingTime":84
}

Everything downstream consumes this same structure.

3. Local Data Layer

Nothing uploads immediately.

Everything is stored locally first.

Local Image Storage

Stores

JPEG Images

Image Cache

Thumbnails
Drift Database

Stores

Image Metadata

Detection Results

Upload Status

Camera Used

Timestamp

File Path

Processing Time

User Notes

Gallery

Gallery displays

Image

↓

Detection Results

↓

Metadata

↓

Upload Status

4. Synchronization Layer

The Sync Manager is completely isolated from the Vision Engine.

The Vision Engine never communicates directly with Google services.

Upload Flow
Image Captured

↓

Stored Locally

↓

Queued

↓

Sync Manager

↓

Google Apps Script

↓

Google Drive

↓

Google Sheets
Google Apps Script

Apps Script acts as the temporary backend.

Responsibilities

Receive Image

Save Image into Google Drive

Generate Drive URL

Insert Metadata into Google Sheets

Return Success Response

Google Drive

Stores only

Images

Thumbnails

Future Videos

Example

Images/

2026/

08/

IMG0001.jpg
Google Sheets

Stores metadata only.

Example Columns

Image ID

Timestamp

Camera Source

Drive URL

Face Count

Detected Objects

OCR Result

QR Result

Latitude

Longitude

Processing Time

Upload Status

Notes

The sheet becomes your searchable index, while Drive stores the actual image files.

Application Modules
CodeVoice Vision

├── Dashboard
│
├── Camera Manager
│
├── Vision Engine
│
├── Gallery
│
├── Local Database
│
├── Local Storage
│
├── Sync Manager
│
├── Google Apps Script Client
│
├── Device Manager
│
├── Settings
│
└── Shared Utilities

Each module has a single responsibility, making the project easier to maintain and extend.

Recommended Tech Stack
Layer	Technology
UI	Flutter
State Management	Riverpod
Local Database	Drift (SQLite)
Local File Storage	App-specific storage on Android
Camera APIs	CameraX (native Android) with Flutter integration; USB Host API for external USB cameras; protocol adapters for ESP32/IP cameras
Face Detection	MediaPipe
Object Detection	YOLO (TensorFlow Lite)
OCR	PaddleOCR
QR Detection	Google ML Kit Barcode Scanner
AI Runtime	TensorFlow Lite + MediaPipe
Image Processing	Flutter image package or OpenCV only if advanced processing is needed
Cloud Sync	Google Apps Script (Web App)
Cloud Image Storage	Google Drive
Metadata Storage	Google Sheets
Authentication	None (Version 1.0)
Future Expansion

One reason I like this architecture is that nothing in the Vision Engine depends on Google Drive or Google Sheets.

