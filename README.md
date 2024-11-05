<a name="readme-top"></a>

# Macro MyPal Notification App
![MyPal logo](assets/MyPal-for-ADULTS_App_LOGO3.png)

## Overview

The MyPal Notification App is a Flutter-based component of the MyPal project, designed to enhance patient care through smart and personalized notification scheduling. This app plays a crucial role in managing and timing notifications effectively, ensuring that patients receive reminders and prompts at the most suitable moments, tailored to their individual cancer-related schedules and preferences.
The core functionality of the app is built around expert-driven logic that identifies and excludes poorly timed moments for notifications, helping to improve patient engagement and ensure the timely completion of important questionnaires. By leveraging detailed patient data and expert input, the app aligns with the MyPal project's mission to provide a more personalized and patient-centric digital health experience.
It's important to note that this repository contains only the notification framework and macro-layer logic—responsible for determining the optimal timing for notifications based on available data. This app is not a standalone solution and requires integration with the rest of the MyPal application to function as intended. Without the full MyPal system, this component will not operate independently, as it relies on the broader MyPal infrastructure for patient data and overall system interactions.

## Features

- **Macro Scheduling**: Schedule and manage recurring notifications with ease.
- **User-Centric Design**: Simplified user interface focused on user experience.
- **Cross-Platform**: Supports both Android and iOS platforms.

## Technologies Used

- **Framework**: Flutter
  - [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications)
- **Languages**: Dart
- **Platforms Supported**: Android, iOS

## Getting Started

### Prerequisites

- Flutter SDK installed. [Install Flutter](https://flutter.dev/docs/get-started/install)
- Android Studio or Visual Studio Code for development.
- MyPal for adults repository pulled to your local environment.
  - Unfortunately it is not available for download and editing.

### Installation

- Unfortunately this app is one of the components that make the MyPal for adults application.
- This means this app cannot run by itself. It is embedded in the MyPal for adults app available only via the Fraunhofer GitLab website.

## Folder Structure

```plaintext
macro_mypal_notification/
├── android/              # Android native code
├── ios/                  # iOS native code
├── lib/                  # Dart code (main application)
├── test/                 # Unit and widget tests
├── pubspec.yaml          # Project configuration
└── README.md             # Project documentation
```

## Contributing

We welcome contributions! Please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/YourFeature`).
3. Commit your changes (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature/YourFeature`).
5. Open a pull request.

## Acknowledgments

- The Flutter community for continuous support.
- A huge thank you to all the MyPal consortium members that aided in the design and implementation of this service.

Also the present service has been presented in a Poster form at the 19th International Conference on Informatics, Management and Technology in Healthcare (#ICIMTH2021). You can find it [Here](https://ebooks.iospress.nl/doi/10.3233/SHTI210967)

## Learn about MyPal

This project is a starting point for the Macro-timing layer of the Notification service that MyPal platform is providing.

A few resources to get you informed about the MyPal project and this app's developer:

- [MyPal: Fostering Palliative Care of Adults and Children with Cancer through Advanced Patient Reported Outcome Systems](https://mypal-project.eu/)
- [CERTH | INAB: The project Coordinator Partner](https://www.inab.certh.gr/)

![MyPal logo](assets/MyPal%20Logo.png)

## Contact

For any queries or suggestions, please contact:
- **Designed & Developed**: Panos Bonotis - [LinkedIn](https://www.linkedin.com/in/panosbonotis/) - pbonotis@certh.gr
- Please pose any questions [online website](https://mypal-project.eu/contact-us/), which offers plenty of information of the present state of the MyPal project and much more..

<p align="right">(<a href="#readme-top">back to top</a>)</p>