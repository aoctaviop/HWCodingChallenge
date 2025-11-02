# HWCodingChallenge
iOS Engineering Code Challenge for HatchWorksAI

## Base App Architecture

| Layer         | Responsibility              | Swift / Combine Feature                      |
| ------------- | --------------------------- | -------------------------------------------- |
| **Model**     | Data + business logic       | Plain Swift types                            |
| **ViewModel** | Glue between Model & View   | `ObservableObject`, `@Published`             |
| **View**      | UI + reacts to data changes | SwiftUI + `@ObservedObject` / `@StateObject` |

## Network Layer

| Concept                     | Usage                                                                |
| --------------------------- | -------------------------------------------------------------------- |
| **Generics**                | `<T: Codable>` makes the network layer reusable for any model |
| **Structured Concurrency**  | `async/await` simplifies async network code                          |
| **Codable**                 | Decodes JSON into Swift structs                                      |
| **URLSession & URLRequest** | Handles actual HTTP networking                                       |
