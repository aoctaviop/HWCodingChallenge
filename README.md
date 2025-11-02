# HWCodingChallenge
iOS Engineering Code Challenge for HatchWorksAI

Base App Architecture

| Layer         | Responsibility              | Swift / Combine Feature                      |
| ------------- | --------------------------- | -------------------------------------------- |
| **Model**     | Data + business logic       | Plain Swift types                            |
| **ViewModel** | Glue between Model & View   | `ObservableObject`, `@Published`             |
| **View**      | UI + reacts to data changes | SwiftUI + `@ObservedObject` / `@StateObject` |
