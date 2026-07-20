# Flutter Web Quiz Application

Technical Assessment project for **EvolvEd. Ventures – Floreo**.

A production-ready, responsive Flutter Web Quiz Application demonstrating **Clean Architecture** (Feature-First) and **BLoC** state management.

---

## 🌟 Key Features

- **Quiz Navigation**: Navigate via **Prev**, **Next**, or direct **Question Selector Grid** (1–20).
- **Answer Locking**: Answers are permanently locked upon selection to prevent modification.
- **Immediate Feedback & Explanations**: Selection immediately reveals correct (green) / incorrect (red) feedback and detailed calculation explanations.
- **Local Progress Persistence**: Progress (`currentQuestionIndex`, `selectedAnswers`, `isSubmitted`) is automatically saved in **Hive** and restored on page refresh.
- **Submit Validation**: Blocks submission if questions remain unanswered, displaying a clear list of missing questions.
- **Review & Result Mode**: Score summary modal with score, percentage, correct/incorrect counters, and review mode.
- **Responsive Layout**: `LayoutBuilder` breakpoints for Desktop (`≥1024px`), Tablet (`600px–1023px`), and Mobile (`<600px`).

---

## 🛠️ Tech Stack

- **Framework**: Flutter 3.38 (Web)
- **State Management**: `flutter_bloc`
- **Persistence**: `hive` & `hive_flutter`
- **Dependency Injection**: `get_it`
- **Testing**: `bloc_test` & `mocktail`

---

## 🏗️ Architecture

```
Presentation (UI & Widgets)
       │
       ▼
   BLoC Layer (QuizBloc, QuizEvent, QuizState)
       │
       ▼
    Use Cases (GetQuiz, GetQuizProgress, SaveQuizProgress, ResetQuiz)
       │
       ▼
  Repository Interface (QuizRepository)
       │
       ▼
  Repository Implementation (QuizRepositoryImpl)
       ├──► Remote Data Source (QuizRemoteDataSource)
       └──► Local Data Source (QuizLocalDataSource -> Hive Box)
```

---

## 📁 Project Structure

```
lib/
├── core/
│   ├── constants/       # AppColors, AppSpacing, QuizData
│   ├── theme/           # AppTheme
│   └── usecase/         # Base UseCase interface
│
├── features/
│   └── quiz/
│       ├── data/        # Models, Local & Remote DataSources, RepositoryImpl
│       ├── domain/      # Entities, Repository interface, UseCases
│       └── presentation/# QuizBloc, Pages, Modular Widgets
│
├── injection_container.dart # Service locator (GetIt)
└── main.dart            # App entry point
```

---

## 🚀 Getting Started

```bash
# Install dependencies
flutter pub get

# Run on Chrome
flutter run -d chrome

# Run tests
flutter test

# Build Web Release
flutter build web --release
```

---

## 💾 Persistence

- **Box Name**: `floreo_quiz_box`
- **Keys**:
  - `'cached_quiz'`: Cached quiz questions.
  - `'quiz_progress'`: Stores `currentQuestionIndex`, `selectedAnswers` map, and `isSubmitted` boolean.

---

## 📸 Screenshots

| Quiz In-Progress | Result Summary & Review |
|:---:|:---:|
| *(Screenshot Placeholder)* | *(Screenshot Placeholder)* |
