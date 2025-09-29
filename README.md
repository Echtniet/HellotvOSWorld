# HellotvOSWorld

HellotvOSWorld is a tvOS app built with **SwiftUI** that displays dashboard information on customizable cards. The app follows the **MVVM architecture** and uses **Swinject** for dependency injection.

---

## 🚀 Features

- 📺 Display information cards in a dashboard layout
- 🧩 Modular architecture for scalability

---

## ⚙️ Technical Highlights

- 🧱 MVVM architecture for separation of concerns
- 💉 Swinject for scalable and testable dependency injection
- 🎨 Design System planned (e.g., reusable Text component)
- 🧪 Testing planned but not fully implemented yet

---

## 🧱 Architecture

The project follows an **MVVM** architecture:

- **Model** – Domain entities and data structures
- **DTOs** – Represent raw data received from any source (if needed in the future)
- **Repositories** – Provide and prepare data for use cases or view models
- **Use Cases** – Encapsulate business logic and domain rules
- **ViewModel** – Transforms data into UI-ready state for the views
- **View** – SwiftUI interface components and layout
- **DI Container** – Built with Swinject for dependency injection

---

## 🛠 Tech Stack

- **SwiftUI** – Declarative UI
- **Swinject** – Dependency injection
- **XCTest** – Planned for future Unit & UI testing

---

## 🧪 Testing

Testing is planned but not yet implemented. Future coverage will include:

- ✅ Unit Tests – ViewModels, Use Cases, and Repositories
- 🔁 Integration Tests – Data flow validation
- 👀 UI Tests – Simulated tvOS interactions

---

## 🚧 To-Do

- Implement Design System (starting with Text component)
- Add Unit, Integration, and UI test cases
- Improve card layout for scalability
- Add sample/mock data for testing dashboard states
