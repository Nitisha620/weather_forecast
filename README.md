# weather_forecast

A Flutter application for checking **current weather** and viewing the **weather map**. The app follows **clean architecture**, **modular coding practices**, proper **state management**, and robust **error and exception handling** to ensure maintainability and scalability.

---

## Features

- **Home Screen** – Displays real-time weather information for your current location or any searched location.
- **Weather Map Screen** – Visualizes weather conditions (precipitation and temperature) on a map.
- **Search Location** – Search locations worldwide.
- **5 Day Forecast** – Visualizes forecast data using a line chart for clarity.
- **BloC State Management** – Predictable and testable state management.
- **Modular Code Structure** – Organized code for scalability and readability.
- **Proper API Handling** – Robust API calls with error handling and exception management.
- **Responsive & User-Friendly** – Smooth UI interactions and clear error feedback.

---

## Tech Stack

- **Flutter** – Cross-platform mobile app development.
- **Dart** – Programming language.
- **BloC** – State management.
- **Google Maps / OpenWeatherMap APIs** – Fetch weather data and map visualization.
- **Other Packages** – `http`, `flutter_bloc`, `equatable`, etc.

## Project Structure

lib/
├── bloc/ # BloC classes
├── constant/ # Path constants
├── models/ # Data models
├── repository/ # API calls and data handling
├── presentation/ # UI screens
├── widgets/ # Reusable widgets
├── service/ # Location and Google Map Tile Provider
├── styles/ # App text styles and theme
└── utils/ # Utility classes and helpers

## Architectural Decisions

- **State Management:** Chose **BloC** for clear separation of business logic and UI, making it easier to test and maintain.
- **Project Structure:** Modular and layered structure:
- **Error Handling:** Centralized exception handling for API calls and UI feedback.
- **Code Readability:** Followed consistent naming conventions, modular functions, and well-documented classes.

**Trade-offs Made:**

- Used BloC, which adds boilerplate but ensures scalability.
- Focused more on code structure and readability over aggressive performance optimization.  
- Some advanced map animations were simplified to prioritize reliability and maintainability.

---

## Setup Instructions

1. Add GOOGLE_MAPS_API_KEY=****** to android\local.properties file
2. Add OPENWEATHER_API_KEY=********* in assets\.env file

Screenshots :
<img width="200" height="600" alt="Screenshot_1756720165" src="https://github.com/user-attachments/assets/19c3a530-0d33-41f6-b410-bf0e02f3635f" />
<img width="200" height="600" alt="image" src="https://github.com/user-attachments/assets/b1f12687-cc38-4998-8fbd-c880d3b166cb" />
<img width="200" height="600" alt="Screenshot_1756720217" src="https://github.com/user-attachments/assets/d3887f3f-e965-47d1-924c-3749aa531dd4" />
<img width="200" height="600" alt="Screenshot_1756720223" src="https://github.com/user-attachments/assets/2307d2f5-5594-4989-9a0b-8a9806b36374" />
<img width="200" height="600" alt="Screenshot_1756720238" src="https://github.com/user-attachments/assets/d7c99a2b-dba0-43d1-aa8c-3dd02c9d1a5c" />
<img width="398" height="879" alt="Screenshot_1756720249" src="https://github.com/user-attachments/assets/33c140f7-49fd-42f9-a60b-404f80b9b82e" />




