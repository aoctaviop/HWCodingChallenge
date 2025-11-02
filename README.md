# 📰 HWCodingChallenge

A simple, native iOS app that connects to [NewsAPI](https://newsapi.org) to fetch and display current news articles. 

---

## 📱 Overview

**HWCodingChallenge** was developed as part of a coding exercise.
The goal:

> Using any publicly available API (e.g., Yelp, Flickr, New York Times, etc.), build a simple iOS app with at least two screens — one to list items from the API, and another to display detailed information about an item.

This project uses **NewsAPI** as the data source.

---

## 🧩 Architecture

The app follows the **MVVM** pattern using **SwiftUI** and **Combine**:

| Layer         | Responsibility                                                                                      | Key Features                                                                                                                 |
| ------------- | --------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| **Model**     | Defines data structures for news articles (`Codable`).                                              | Simple data representations that mirror API responses.                                                                       |
| **ViewModel** | Handles data fetching, pagination, search, and state management.                                    | Uses `ObservableObject` for reactivity, and `@Published` properties to automatically update SwiftUI views when data changes. |
| **View**      | Declares the UI declaratively in SwiftUI and reacts to `@Published` state changes in the ViewModel. | Uses `@StateObject` or `@ObservedObject` to bind to the ViewModel.                                                           |

---

## ⚙️ Features

* Fetches live news articles using **NewsAPI**
* Displays results in a **paginated feed**
* **Search bar** to query specific topics
* **Detail screen** showing full article information
* Uses **structured concurrency** (`async`/`await`) for networking
* Reactive updates powered by **Combine**
* Clean and testable **MVVM architecture**
* No third-party dependencies

---

## 🧠 Technologies Used

* **Swift 6**
* **SwiftUI**
* **Combine**
* **MVVM Architecture**
* **Structured Concurrency (async/await)**
* **Codable**
* **URLSession / URLRequest**

---

## 🏗️ Project Structure

```
HWCodingChallenge/
│
├── Enums/
│   ├── Category.swift
│   └── Constants.swift
│
├── Model/
│   ├── Article.swift
│   └── News.swift
│
├── Networking/
│   ├── Endpoint.swift
│   ├── NetworkClient.swift
│   ├── NetworkError.swift
│   ├── NewsAPI.swift
│   ├── NewsService.swift
│   └── URLSessionNetworkClient.swift
│
├── ViewModel/
│   ├── ArticleViewModel.swift
│   └── NewsViewModel.swift
│
├── Views/
│   ├── ArticleDetailView.swift
│   ├── ArticleView.swift
│   ├── CachedImage.swift
│   └── NewsListView.swift
│
└── HWCodingChallengeApp.swift
```


---

## 🚀 Getting Started

### Prerequisites

* **Xcode 26.0** or newer
* **iOS 26.0+** deployment target
* **NewsAPI API key**

### Setup Steps

1. Clone this repository:

   ```bash
   git clone https://github.com/your-username/HWCodingChallenge.git
   ```
2. Open the project in Xcode:

   ```bash
   cd HWCodingChallenge
   open HWCodingChallenge.xcodeproj
   ```
3. Add your NewsAPI key in the project (e.g., `NewsAPI.swift`):

   ```swift
   static let apiKey = "YOUR_API_KEY"
   ```
4. Build and run the app on Simulator.

---

## 🧭 App Flow

1. **News Feed Screen**

   * Fetches top news articles
   * Supports finite scroll (pagination)
   * Search bar filters news by keywords

2. **News Detail Screen**

   * Displays the selected article’s title, author, date, and description
   * Allows opening the original source link in Safari

---

## 🧪 Testing

* Unit tests cover the **NetworkService** and **ViewModel** logic.
* Mock data is included for offline testing.
* Run all tests via **Product → Test** in Xcode (`Cmd + U`).

---

## 🧑‍💻 Author

**Octavio Padilla**
