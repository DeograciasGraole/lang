# GraoLang - Language Learning Application

## Project Overview

**GraoLang** is an innovative mobile language learning application that revolutionizes how users acquire new languages through a combination of structured curriculum, interactive exercises, and artificial intelligence. Built with Flutter and leveraging modern software architecture principles, GraoLang provides a comprehensive, user-centric learning experience that adapts to individual progress and learning preferences.

### Vision

To create the most effective and engaging language learning platform that makes fluency achievable for everyone, regardless of their starting point or learning pace. GraoLang combines the best practices of language pedagogy with cutting-edge technology to deliver personalized, interactive, and results-driven language education.

### What Makes GraoLang Unique

**GraoLang** stands out in the crowded language learning market through its unique combination of features:

1. **Intelligent Learning Path**: Unlike static courses, GraoLang's adaptive system ensures users master each concept before advancing, preventing knowledge gaps and building confidence.

2. **AI-Powered Personalization**: The integrated AI tutor doesn't just answer questions—it adapts to the user's current unit, provides contextual practice, and offers real-time corrections tailored to their learning level.

3. **Comprehensive Content Delivery**: Each lesson integrates vocabulary, grammar, and assessment in a cohesive flow, ensuring holistic language development rather than isolated skill practice.

4. **Progress-Driven Motivation**: Visual progress indicators, achievement celebrations, and milestone tracking keep learners engaged and motivated throughout their journey.

5. **Production-Ready Architecture**: Built with scalability and maintainability in mind, using industry-standard patterns and best practices for long-term success.

### Key Features

#### 🎓 Structured Curriculum
- **Modular Units**: Content organized into logical units that build upon each other
- **Sequential Lessons**: Each lesson unlocks only after completing prerequisites
- **Progress Tracking**: Real-time visualization of completion status at unit and lesson levels
- **Adaptive Difficulty**: Content complexity increases naturally with user proficiency

#### 📖 Interactive Content
- **Vocabulary Cards**: Swipeable flashcards with bilingual translations, example sentences, and visual aids
- **Grammar Lessons**: Contextual grammar explanations with side-by-side language comparisons
- **Assessment Quizzes**: Multiple-choice questions with immediate feedback and explanations
- **Multimedia Support**: Images and audio enhance learning and retention

#### 🤖 AI Language Tutor
- **Conversational Practice**: Natural language interactions with GPT-powered assistant
- **Unit-Specific Context**: AI understands current learning unit and adapts conversations
- **Error Correction**: Real-time grammar and vocabulary corrections with explanations
- **Personalized Guidance**: Tailored responses based on user's learning progress

#### 🎯 User Experience
- **Intuitive Navigation**: Clean, modern interface with smooth transitions
- **Visual Feedback**: Progress bars, completion indicators, and achievement animations
- **Celebration Moments**: Confetti animations and success messages upon milestones
- **Responsive Design**: Optimized for various screen sizes and device types

#### 🔒 Security & Privacy
- **Secure Authentication**: Multiple login methods with encrypted token storage
- **Data Protection**: Secure API communication with bearer token authentication
- **Privacy First**: User data handled with industry-standard security practices

### Technical Foundation

GraoLang is built on a robust technical foundation:

- **Flutter Framework**: Cross-platform development ensuring consistent experience on iOS and Android
- **Riverpod State Management**: Type-safe, reactive state management for predictable app behavior
- **Clean Architecture**: Separation of concerns enabling maintainable and testable code
- **RESTful API Integration**: Seamless communication with Laravel backend
- **Performance Optimized**: Reduced frame drops, efficient rendering, and optimized API calls

### Target Audience

GraoLang serves a diverse range of learners:

- **Beginners**: Those starting their language learning journey from scratch
- **Intermediate Learners**: Users looking to improve existing language skills
- **Students**: Educational support for formal language courses
- **Professionals**: Career-focused individuals needing language skills
- **Travelers**: Quick learners seeking practical communication skills
- **Language Enthusiasts**: Hobbyists exploring new languages and cultures

### Learning Methodology

The application implements proven language learning strategies:

- **Spaced Repetition**: Content reviewed at optimal intervals for long-term retention
- **Active Recall**: Interactive exercises require active engagement rather than passive reading
- **Progressive Overload**: Difficulty increases gradually to maintain challenge without overwhelm
- **Immediate Feedback**: Instant corrections help users learn from mistakes in real-time
- **Contextual Learning**: Real-world examples and practical scenarios enhance understanding

### Project Goals

GraoLang aims to:

1. **Democratize Language Learning**: Make quality language education accessible to everyone
2. **Improve Retention**: Use proven methods to ensure long-term knowledge retention
3. **Enhance Engagement**: Keep learners motivated through gamification and progress tracking
4. **Provide Flexibility**: Allow users to learn at their own pace and schedule
5. **Ensure Quality**: Maintain high standards in content delivery and user experience

GraoLang represents a complete language learning solution that bridges the gap between traditional classroom learning and modern digital education, providing users with the tools, motivation, and support needed to achieve language fluency.

## Technology Stack

- **Framework**: Flutter (Dart SDK ^3.8.1)
- **State Management**: Flutter Riverpod 3.0.3
- **HTTP Client**: Dio 5.9.0
- **Authentication**: Firebase Core & Firebase Auth
- **Social Authentication**: Google Sign-In
- **Secure Storage**: Flutter Secure Storage
- **UI Components**: Custom widgets with Material Design
- **Animations**: Lottie, Confetti, Avatar Glow
- **Backend API**: RESTful API (Laravel-based)

## Architecture

The application follows a clean architecture pattern with clear separation of concerns:

```
lib/
├── data/
│   ├── models/          # Data models
│   ├── providers/        # Riverpod state providers
│   └── services/         # API and external services
├── presentation/
│   ├── Auth/             # Authentication screens
│   ├── onboarding/       # Onboarding flow
│   └── dashboard/        # Main application screens
└── main.dart             # Application entry point
```

---

## State Management

The application uses **Flutter Riverpod** for state management, providing a reactive and type-safe approach to managing application state. The state management architecture includes:

### 1. **Authentication State Management**

**Provider**: `authNotifierprovider` (AsyncNotifierProvider)

- **Location**: `lib/data/providers/auth_notifier.dart`
- **Purpose**: Manages user authentication state including login, registration, and logout
- **State Type**: `AsyncValue<User?>`
- **Key Methods**:
  - `register(String name, String email, String password)`: Handles user registration
  - `login(String email, String password)`: Handles user login
  - `logout()`: Clears user session and logs out

### 2. **Token Management**

**Provider**: `tokenNotifierProvider` (StateNotifierProvider)

- **Location**: `lib/data/providers/tokenSave.dart`
- **Purpose**: Manages authentication tokens securely using Flutter Secure Storage
- **State Type**: `String?`
- **Key Methods**:
  - `setToken(String token)`: Saves token to secure storage
  - `clearToken()`: Removes token from storage
  - `_loadToken()`: Loads token on app initialization

### 3. **Unit Data Management**

**Provider**: `unitsProvider` (FutureProvider)

- **Location**: `lib/data/providers/UnitProvider.dart`
- **Purpose**: Fetches and provides list of learning units with progress information
- **State Type**: `Future<List<dynamic>>`
- **Dependencies**: Requires authenticated user and API service

### 4. **Lesson Data Management**

**Provider**: `lessonsByUnitProvider` (FutureProvider.family)

- **Location**: `lib/data/providers/LessonProvider.dart`
- **Purpose**: Fetches lessons for a specific unit
- **State Type**: `Future<List<Lesson>>`
- **Parameters**: `unitId` (int)

### 5. **Lesson Content Management**

**Provider**: `lessonsContentProvider` (FutureProvider.family)

- **Location**: `lib/data/providers/lessonContent.dart`
- **Purpose**: Fetches complete lesson content including vocabularies, grammars, and quizzes
- **State Type**: `Future<List<LessonContent>>`
- **Parameters**: `(unitId, lessonId)` tuple

### 6. **User Progress Management**

**Provider**: `userProgressProvider` (FutureProvider.family)

- **Location**: `lib/data/providers/userprogress.dart`
- **Purpose**: Updates and tracks user progress for lessons
- **State Type**: `Future<Map<String, dynamic>>`
- **Parameters**: `UserProgressParams` (lessonId, completed, percentage)

### 7. **API Service Provider**

**Provider**: `apiServiceProvider` (Provider)

- **Location**: `lib/data/providers/LessonProvider.dart` & `lib/data/providers/UnitProvider.dart`
- **Purpose**: Provides configured API service instance with authentication token
- **State Type**: `ApiService`
- **Dependencies**: Watches `tokenNotifierProvider` for token updates

---

## Data Models

### 1. **User Model**

**Location**: `lib/data/models/user_model.dart`

Represents user information and authentication data.

```dart
class User {
  final int id;
  final String name;
  final String email;
  final String token;
}
```

**Key Features**:

- JSON serialization/deserialization
- Token management for API authentication

### 2. **Unit Model**

**Location**: `lib/data/models/unit_model.dart`

Represents a learning unit/module containing multiple lessons.

```dart
class Unit {
  final int id;
  final String title;
  final String description;
  final String image;
  final int total_lessons;
  final int completed_lessons;
  final int total_percentage;
}
```

**Key Features**:

- Progress tracking (completed lessons, total percentage)
- Visual representation with images

### 3. **Lesson Model**

**Location**: `lib/data/models/lessons_model.dart`

Represents an individual lesson within a unit.

```dart
class Lesson {
  final int id;
  final int unitId;
  final int languageId;
  final String title;
  final String description;
  final int order;
  final double? progressPercentage;
  final bool? completed;
}
```

**Key Features**:

- Sequential ordering system
- Progress tracking (percentage and completion status)
- Lesson unlocking mechanism based on progress

### 4. **LessonContent Model**

**Location**: `lib/data/models/lessonContent.dart`

Aggregates all content for a lesson including vocabularies, grammars, and quizzes.

```dart
class LessonContent {
  final int id;
  final int unitId;
  final int languageId;
  final String title;
  final String description;
  final int order;
  final List<Vocabulary> vocabularies;
  final List<Grammar> grammars;
  final List<Quiz> quizzes;
}
```

**Key Features**:

- Comprehensive lesson data structure
- Nested model relationships

### 5. **Vocabulary Model**

**Location**: `lib/data/models/vocabulary_model.dart`

Represents vocabulary words with translations and examples.

```dart
class Vocabulary {
  final int id;
  final String wordEn;
  final String wordTr;
  final String exampleEn;
  final String exampleTr;
  final String? image;
}
```

**Key Features**:

- Bilingual word representation
- Example sentences for context
- Optional image support

### 6. **Grammar Model**

**Location**: `lib/data/models/grammars_model.dart`

Represents grammar rules and explanations.

```dart
class Grammar {
  final int id;
  final int lessonId;
  final int languageId;
  final String title;
  final String description;
  final String sentenceEn;
  final String sentenceTr;
  final String note;
  final String? image;
}
```

**Key Features**:

- Grammar rule explanations
- Example sentences in both languages
- Additional notes for clarification

### 7. **Quiz Model**

**Location**: `lib/data/models/quiz_model.dart`

Represents quiz questions with multiple-choice options.

```dart
class Quiz {
  final int id;
  final int lessonId;
  final int languageId;
  final String question;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final String correctOption;
  final String? image;
}
```

**Key Features**:

- Multiple-choice question format
- Correct answer tracking
- Optional image support for visual questions

---

## Application Pages & Screens

### Authentication Flow

#### 1. **Onboarding Screen**

**Location**: `lib/presentation/onboarding/onboardingscreen.dart`

- **Type**: StatefulWidget
- **Purpose**: Introduces users to the application through a multi-page onboarding experience
- **Features**:
  - PageView with smooth page transitions
  - Three introductory screens (IntroPage1, IntroPage2, IntroPage3)
  - Smooth page indicator for navigation
  - "Next" and "Done" button controls
- **Navigation**: Leads to Get Started screen

#### 2. **Get Started Screen**

**Location**: `lib/presentation/onboarding/getStarted_screen.dart`

- **Type**: StatelessWidget
- **Purpose**: Welcome screen with app branding and call-to-action
- **Features**:
  - Animated background with gradient overlay
  - App introduction text
  - Glowing "Get Started" button with AvatarGlow animation
  - Motivational messaging
- **Navigation**: Leads to Registration screen

#### 3. **Registration Screen**

**Location**: `lib/presentation/Auth/register.dart`

- **Type**: ConsumerStatefulWidget
- **Purpose**: User account creation
- **Features**:
  - Form validation (name, email, password)
  - Real-time error handling
  - Loading states during registration
  - Navigation to login screen
  - Automatic navigation to dashboard upon successful registration
- **State Management**: Uses `authNotifierprovider` for registration logic
- **Validation**:
  - Name: Required field
  - Email: Must contain '@' symbol
  - Password: Minimum 6 characters

#### 4. **Login Screen**

**Location**: `lib/presentation/Auth/login.dart`

- **Type**: ConsumerStatefulWidget
- **Purpose**: User authentication
- **Features**:
  - Email and password authentication
  - Form validation
  - Social authentication buttons (Google, Apple)
  - Error message display
  - Loading indicators
  - Navigation to registration screen
  - Automatic navigation to dashboard upon successful login
- **State Management**: Uses `authNotifierprovider` for login logic
- **Social Auth**: Google Sign-In integration

### Main Application Flow

#### 5. **Main Dashboard**

**Location**: `lib/presentation/dashboard/dashboard.dart`

- **Type**: StatefulWidget
- **Purpose**: Main navigation hub with bottom navigation bar
- **Features**:
  - Curved navigation bar with three tabs:
    - Home (DashboardScreen)
    - Lessons (LessonScreen)
    - Chat (ChatScreen)
  - Smooth tab transitions
  - Icon-based navigation
- **Navigation**: Routes to different sections of the app

#### 6. **Home Dashboard Page**

**Location**: `lib/presentation/dashboard/pages/home_dashboar_page.dart`

- **Type**: ConsumerStatefulWidget
- **Purpose**: Main home screen displaying user progress and available units
- **Features**:
  - User profile header with welcome message
  - Logout functionality
  - Promotional carousel with three slides:
    - "Learn Anytime, Anywhere"
    - "Track Your Progress"
    - "Earn Achievements"
  - Units grid display with:
    - Progress indicators (circular percent indicators)
    - Unit titles and descriptions
    - Completed lessons count
    - Visual unit cards with images
  - Dynamic unit loading from API
- **State Management**:
  - Uses `authNotifierprovider` for user data
  - Uses `unitsProvider` for unit data
- **Navigation**: Tapping a unit navigates to Lesson Dashboard Page

#### 7. **Lesson Dashboard Page**

**Location**: `lib/presentation/dashboard/pages/lesson_dashboard_page.dart`

- **Type**: ConsumerStatefulWidget
- **Purpose**: Displays lessons within a selected unit
- **Features**:
  - Unit header with title and description
  - Timeline-based lesson list using TimelineTile widget
  - Lesson progress indicators
  - Lesson locking/unlocking system:
    - First lesson always unlocked
    - Subsequent lessons unlock upon completion of previous lesson
  - Visual lesson cards with:
    - Lesson images
    - Progress bars
    - Lock icons for locked lessons
  - Dynamic lesson loading from API
- **State Management**: Uses `lessonsByUnitProvider` for lesson data
- **Navigation**: Tapping an unlocked lesson navigates to Lesson Content Page

#### 8. **Lesson Content Page**

**Location**: `lib/presentation/dashboard/lessons_page/lesson_content.dart`

- **Type**: ConsumerStatefulWidget
- **Purpose**: Displays vocabulary content for a lesson
- **Features**:
  - PageView for swiping through vocabulary cards
  - Progress bar showing completion status
  - Vocabulary cards displaying:
    - English word
    - Turkish translation
    - Example sentences in both languages
    - Images
    - Audio playback button
  - "Next" button to navigate between vocabulary items
  - "Done" button on last vocabulary item
  - Smooth page transitions
- **State Management**: Uses `lessonsContentProvider` for lesson content
- **Navigation**: "Done" button navigates to Quiz Page

#### 9. **Quiz Page**

**Location**: `lib/presentation/dashboard/activities/Quiz.dart`

- **Type**: StatefulWidget
- **Purpose**: Interactive quiz assessment for lesson completion
- **Features**:
  - PageView for multiple quiz questions
  - Quiz cards with:
    - Question text
    - Four multiple-choice options
    - Correct answer validation
    - Visual feedback for correct/incorrect answers
  - "Next" button to proceed through questions
  - "Done" button on final question
  - Non-scrollable PageView (physics: NeverScrollableScrollPhysics)
- **Navigation**: "Done" button navigates to Finish Lesson Page

#### 10. **Finish Lesson Page**

**Location**: `lib/presentation/dashboard/activities/finishLesson.dart`

- **Type**: ConsumerStatefulWidget
- **Purpose**: Celebration screen after lesson completion
- **Features**:
  - Confetti animation on completion
  - Lottie success animation
  - Dynamic messages (Lesson completed / Unit completed)
  - Progress update to backend:
    - Marks current lesson as completed (100%)
    - Unlocks next lesson if available
    - Marks unit as completed if all lessons finished
  - Provider invalidation to refresh data
  - "Continue" button to return to dashboard
- **State Management**:
  - Uses `userProgressProvider` for progress updates
  - Uses `lessonsByUnitProvider` for lesson data
  - Invalidates `unitsProvider` and `lessonsByUnitProvider` on completion
- **Navigation**: Returns to Main Dashboard

#### 11. **Chat Dashboard Page**

**Location**: `lib/presentation/dashboard/pages/chat_dashboard_page.dart`

- **Type**: StatefulWidget
- **Purpose**: AI-powered language learning assistant
- **Features**:
  - Unit selection interface (initial screen)
  - Chat interface with message history
  - Real-time AI responses using OpenAI API
  - Typing animation for AI responses
  - Loading indicators
  - Message bubbles (user and AI)
  - Smooth animations and transitions
  - Auto-scroll to latest message
  - Text input with send button
- **AI Integration**: Uses `apichatgpt.dart` service for OpenAI API communication
- **UI Features**:
  - Gradient background
  - AnimatedSwitcher for smooth transitions
  - Unit selection grid with images
  - Chat message bubbles with avatars

### Supporting Components

#### 12. **Vocabulary Card Widget**

**Location**: `lib/presentation/dashboard/lessons_page/vocabulery.dart`

- **Type**: StatelessWidget
- **Purpose**: Reusable vocabulary display component
- **Features**:
  - Word display (English and Turkish)
  - Example sentences
  - Image support (local and network)
  - Audio playback button
  - Google Fonts styling
  - Responsive design

#### 13. **Quiz Card Widget**

**Location**: `lib/presentation/dashboard/activities/cardQuiz.dart`

- **Type**: StatefulWidget
- **Purpose**: Individual quiz question display component
- **Features**:
  - Question text display
  - Four option buttons
  - Answer validation
  - Visual feedback (correct/incorrect)
  - Disabled state after selection

---

## Services

### 1. **API Service**

**Location**: `lib/data/services/ApiService.dart`

- **Purpose**: Centralized HTTP client for backend API communication
- **Base URL**: `http://10.0.2.2:8000/api`
- **Key Methods**:
  - `fetchUnits()`: Retrieves all learning units
  - `fetchLessonsByUnit(int unitId)`: Retrieves lessons for a unit
  - `fetchLessonsContentByLessonUnit(int unitId, int lessonId)`: Retrieves complete lesson content
  - `register(String username, String email, String password)`: User registration
  - `login(String email, String password)`: User authentication
  - `logout(String token)`: User logout
  - `userProgress(int lessonId, bool completed, int percentage)`: Updates user progress
  - `loginWithGoogle()`: Google Sign-In integration
- **Authentication**: Bearer token in Authorization header
- **Error Handling**: Comprehensive error handling with try-catch blocks

### 2. **ChatGPT API Service**

**Location**: `lib/data/services/apichatgpt.dart`

- **Purpose**: Integration with OpenAI API for AI chat functionality
- **Base URL**: `https://api.openai.com/v1`
- **Key Methods**:
  - `getAIResponse(String userMessage)`: Sends user message to OpenAI and returns AI response
- **Model**: GPT-4o-mini
- **Features**:
  - System prompt for language tutoring
  - Context-aware responses
  - Error handling with user-friendly messages

---

## Key Features

### 1. **Progress Tracking**

- Real-time progress updates for lessons and units
- Visual progress indicators (circular and linear)
- Percentage-based completion tracking
- Automatic lesson unlocking system

### 2. **User Authentication**

- Email/password authentication
- Social authentication (Google Sign-In)
- Secure token storage using Flutter Secure Storage
- Session management

### 3. **Interactive Learning**

- Swipeable vocabulary cards
- Interactive quizzes with immediate feedback
- Visual learning with images
- Audio playback support (placeholder)

### 4. **AI-Powered Assistance**

- Conversational AI tutor
- Context-aware responses
- Unit-specific practice sessions
- Real-time typing animations

### 5. **User Experience**

- Smooth animations and transitions
- Confetti celebrations on completion
- Loading states and error handling
- Responsive design
- Modern UI with Material Design

---

## Navigation Flow

```
Onboarding Screen
    ↓
Get Started Screen
    ↓
Registration/Login Screen
    ↓
Main Dashboard
    ├── Home Dashboard (Units Grid)
    │       ↓
    │   Lesson Dashboard (Lessons Timeline)
    │       ↓
    │   Lesson Content (Vocabulary Cards)
    │       ↓
    │   Quiz Page
    │       ↓
    │   Finish Lesson Page
    │       ↓
    │   (Back to Main Dashboard)
    │
    ├── Lesson Dashboard (Direct Access)
    │
    └── Chat Dashboard (AI Assistant)
```

---

## Dependencies

### Core Dependencies

- `flutter_riverpod: ^3.0.3` - State management
- `dio: ^5.9.0` - HTTP client
- `firebase_core: ^4.1.0` - Firebase integration
- `firebase_auth: ^6.0.2` - Authentication
- `google_sign_in: ^6.3.0` - Google authentication
- `flutter_secure_storage: ^9.2.4` - Secure storage

### UI Dependencies

- `lottie: ^3.3.1` - Animations
- `confetti: ^0.8.0` - Confetti effects
- `avatar_glow: ^3.0.1` - Glowing animations
- `smooth_page_indicator: ^1.2.1` - Page indicators
- `percent_indicator: ^4.2.5` - Progress indicators
- `timeline_tile: ^2.0.0` - Timeline widgets
- `curved_navigation_bar: ^1.0.6` - Navigation bar
- `google_fonts: ^6.3.2` - Custom fonts

---

## Project Structure Summary

```
lib/
├── data/
│   ├── models/
│   │   ├── user_model.dart
│   │   ├── unit_model.dart
│   │   ├── lessons_model.dart
│   │   ├── lessonContent.dart
│   │   ├── vocabulary_model.dart
│   │   ├── grammars_model.dart
│   │   └── quiz_model.dart
│   ├── providers/
│   │   ├── auth_notifier.dart
│   │   ├── tokenSave.dart
│   │   ├── UnitProvider.dart
│   │   ├── LessonProvider.dart
│   │   ├── lessonContent.dart
│   │   └── userprogress.dart
│   └── services/
│       ├── ApiService.dart
│       └── apichatgpt.dart
├── presentation/
│   ├── Auth/
│   │   ├── login.dart
│   │   └── register.dart
│   ├── onboarding/
│   │   ├── onboardingscreen.dart
│   │   ├── getStarted_screen.dart
│   │   ├── intro_screens.dart
│   │   ├── intro_screens2.dart
│   │   └── intro_screens3.dart
│   └── dashboard/
│       ├── dashboard.dart
│       ├── pages/
│       │   ├── home_dashboar_page.dart
│       │   ├── lesson_dashboard_page.dart
│       │   └── chat_dashboard_page.dart
│       ├── lessons_page/
│       │   ├── lesson_content.dart
│       │   ├── vocabulery.dart
│       │   └── grammr_lesson.dart
│       └── activities/
│           ├── Quiz.dart
│           ├── cardQuiz.dart
│           └── finishLesson.dart
├── StateNotifıer.dart
├── firebase_options.dart
└── main.dart
```

---

## Conclusion

GraoLang is a comprehensive language learning application built with Flutter and Riverpod, featuring a modern architecture, robust state management, and an intuitive user interface. The application provides a complete learning experience from onboarding through lesson completion, with progress tracking, interactive quizzes, and AI-powered assistance. The codebase follows best practices with clear separation of concerns, reusable components, and efficient state management patterns.
