# HealthcareSocialApp

A SwiftUI iOS application combining a **social health feed** (WaveIn API) with a **Healthcare AI Chatbot** (OpenAI GPT-4o mini). Users authenticate via Firebase, browse paginated posts with rich media, and converse with an AI assistant restricted exclusively to healthcare topics.

---

## Requirements

| Tool | Minimum version |
|---|---|
| Xcode | 15.0+ |
| iOS Deployment Target | 17.0+ |
| Swift | 5.9+ |
| Firebase iOS SDK | via Swift Package Manager (auto-resolved) |

---

## Project Structure

```
HealthcareSocialApp/
├── App/
│   └── HealthcareSocialAppApp.swift     App entry point, FirebaseApp.configure()
├── ContentView.swift
├── Core/
│   ├── Firebase/
│   │   └── FirebaseAuthManager.swift    Auth state listener, token management
│   ├── Network/
│   │   ├── APIClient.swift              Generic async/await HTTP client
│   │   └── APIError.swift              Typed error enum
│   └── Utilities/
│       ├── Color+Extension.swift
│       └── DateFormatter+Extension.swift
├── Models/
│   ├── ChatMessage.swift                ChatMessage + OpenAI request/response models
│   ├── Pagination.swift                 PaginatorRequest / Paginator / PostRequest
│   └── PostResponse.swift               HealthData / FeedData / Feed
├── Services/
│   ├── AIService.swift                  OpenAI ChatCompletion + healthcare system prompt
│   └── PostService.swift                WaveIn paginated post fetching
├── ViewModels/
│   ├── ChatViewModel.swift              Conversation state, AI call orchestration
│   ├── LoginViewModel.swift             Firebase email/password sign-in
│   └── PostListViewModel.swift          Pagination state machine
└── Views/
    ├── Login/
    │   └── LoginView.swift
    ├── MainTabView.swift
    ├── Posts/
    │   ├── PostListView.swift
    │   ├── PostRowView.swift
    │   ├── MediaContentView.swift       Routes mediaType → correct sub-view
    │   ├── ImagePostView.swift          mediaType 1/2/3
    │   ├── VideoPostView.swift          mediaType 3 (AVPlayer)
    │   ├── AudioPostView.swift          mediaType 4 (AVFoundation)
    │   └── PDFPostView.swift            mediaType 5 (PDFKit)
    └── Chat/
        ├── ChatView.swift
        ├── ChatBubbleView.swift         User/assistant bubbles + typing indicator
        └── MessageInputView.swift       Expandable input bar
```

---

## Setup Instructions

### Step 1 — Clone and Open

```bash
git clone <repo-url>
open "HealthcareSocialApp/HealthcareSocialApp.xcodeproj"
```

> Xcode will automatically resolve the Firebase Swift Package dependency on first open. Wait for **"Resolving Package Graph"** to finish before building.

---

### Step 2 — Firebase Configuration

#### 2a. Create or open a Firebase project

1. Go to the [Firebase Console](https://console.firebase.google.com).
2. Create a new project.

#### 2b. Register the iOS app

1. In the Firebase Console, click **Add app → iOS**.
2. Enter the **Bundle ID** — must match Xcode's bundle ID exactly:
   - Xcode → Target → **General → Bundle Identifier** (e.g. `Apple.HealthcareSocialApp`)
3. Download `GoogleService-Info.plist`.

#### 2c. Add `GoogleService-Info.plist` to Xcode

1. Drag `GoogleService-Info.plist` into the Xcode **project navigator**.
2. In the dialog, ensure **"Add to targets: HealthcareSocialApp"** is checked.
3. Click **Finish**.

#### 2d. Enable Email/Password Authentication

1. Firebase Console → **Authentication → Sign-in method**.
2. Click **Email/Password** → toggle **Enable** → **Save**.

#### 2e. Create a test user

Firebase Console → **Authentication → Users → Add user**

Enter any email and password — use these credentials to log in to the app.

> `FirebaseApp.configure()` is called in `HealthcareSocialAppApp.init()`. No code changes are needed; just having `GoogleService-Info.plist` in the target is sufficient.

---

### Step 3 — OpenAI API Key

#### 3a. Get an API key

Visit [platform.openai.com/api-keys](https://platform.openai.com/api-keys) and create a new secret key.

#### 3b. Add the key to `Secrets.xcconfig`

Open `Secrets.xcconfig` at the project root and replace the placeholder:

```
OPENAI_API_KEY = sk-proj-xxxxxxxxxxxxxxxxxxxxxxxx
```

#### 3c. Link `Secrets.xcconfig` to the Xcode project

1. In Xcode, click the **blue project icon** in the Navigator.
2. Select the **project** (not the target) → **Info** tab → **Configurations**.
3. Expand **Debug** and set the configuration file to `Secrets`.
4. Expand **Release** and do the same.

#### 3d. Add the key to `Info.plist`

1. Open `HealthcareSocialApp/Info.plist` in Xcode.
2. Add a new row with:
   - **Key:** `OPENAI_API_KEY`
   - **Value:** `$(OPENAI_API_KEY)`

#### 3e. Protect the key in version control

Verify `Secrets.xcconfig` is listed in `.gitignore`:

```gitignore
Secrets.xcconfig
```

---

### Step 4 — Build and Run

1. Select any **iPhone 15** (iOS 17+) simulator from the Xcode scheme picker.
2. Press **⌘R**.

---

## Firebase Integration Details

### Authentication Flow

`FirebaseAuthManager` (a `@MainActor ObservableObject` singleton) wraps Firebase Auth:

```
App launch
    └── FirebaseAuthManager.init()
            └── Auth.auth().addStateDidChangeListener { user in
                    ├── isLoggedIn = (user != nil)
                    ├── currentUser = user
                    └── bearerToken = user.getIDToken()   ← async Firebase ID token
                }
```

- **Login:** `LoginViewModel` calls `FirebaseAuthManager.signIn(email:password:)` → `Auth.auth().signIn(withEmail:password:)`.
- **Logout:** `PostListViewModel.signOut()` → `FirebaseAuthManager.signOut()` → `Auth.auth().signOut()`. A confirmation alert is shown before signing out.
- **Token refresh:** `FirebaseAuthManager.freshToken()` calls `user.getIDToken(forcingRefresh: false)`, which Firebase refreshes automatically when expired.

### Root Navigation

`RootView` switches between `LoginView` and `MainTabView` based on `authManager.isLoggedIn`:

```swift
if authManager.isLoggedIn {
    MainTabView()
} else {
    LoginView()
}
```

---

## Post List API Integration

### Endpoint

```
POST https://mobileapidev.wavedin.app/api/Post/home
```

### Request Body

```json
{
  "paginator": {
    "pageSize": 20,
    "pageNumber": 1,
    "totalPages": 1,
    "nextPage": <cursor>,
    "previousPage": <cursor - 1>
  },
  "postCategoryType": 2,
  "postType": 1,
  "tagId": "",
  "coordinates": [0.0, 0.0],
  "enableUserTagBasedFilter": 1
}
```

### Authentication

The Firebase ID token is sent as a Bearer token in the `Authorization` header:

```
Authorization: Bearer <Firebase ID Token>
```

`PostListViewModel` retrieves the token from `FirebaseAuthManager.bearerToken` (cached) or calls `freshToken()` if the cache is empty.

### Response Model

```
HealthData
└── data: FeedData
        ├── feeds: [Feed]          Array of post objects
        └── paginator: Paginator   Next page cursor and total page count
```

### Media URL Resolution

The WaveIn API returns **relative paths** for images, audio, and PDFs — but **absolute HTTPS URLs** for videos. `APIClient.fullMediaURL(from:)` prepends the blob base URL to relative paths:

```swift
static let mediaBaseURL = "https://wavedinblobs.blob.core.windows.net/wavedinblobs/"
```

### Media Type Routing

`MediaContentView` routes each post to the correct renderer based on `mediaType`:

| `mediaType` | View |
|---|---|
| `nil` / no media | Text-only post |
| 1, 2, 3 (image) | `ImagePostView` (AsyncImage) |
| 3 (video) | `VideoPostView` (AVPlayer) |
| 4 (audio) | `AudioPostView` (AVFoundation) |
| 5 (PDF) | `PDFPostView` (PDFKit) |

---

## Pagination Implementation

### Strategy: Cursor-based via `nextPage`

The API uses a cursor model — each response returns the `nextPage` value to use in the following request. The app does not use simple offset/page-number pagination.

### State in `PostListViewModel`

| Property | Purpose |
|---|---|
| `nextPageCursor: Int` | The cursor sent in the next request (starts at `1`) |
| `totalPages: Int` | Total pages reported by the API |
| `hasMorePages: Bool` | Guards against fetching past the end |
| `isLoading: Bool` | Prevents duplicate concurrent requests |
| `paginationError: String?` | Shown in-list if a subsequent page fails |

### Load Flow

```
PostListView appears
    └── .task { await viewModel.loadInitialPosts() }
            └── loadNextPage()
                    ├── Guard: !isLoading && hasMorePages
                    ├── Fetch bearerToken (cached or refreshed)
                    ├── POST /api/Post/home { nextPage: nextPageCursor }
                    ├── Append feeds to posts array
                    └── Update nextPageCursor from paginator.nextPage
                            └── if nextPage == 0 || nextPage > totalPages → hasMorePages = false
```

### Infinite Scroll Trigger

The last visible `PostRowView` fires `.onAppear` which calls `loadNextPage()`:

```swift
PostRowView(post: post)
    .onAppear {
        if post.id == viewModel.posts.last?.id {
            Task { await viewModel.loadNextPage() }
        }
    }
```

### Pull-to-Refresh

`ScrollView.refreshable` calls `retryInitialLoad()`, which resets all state and re-fetches from page 1.

### Error Handling

- **Initial load failure** → full-screen error view with a **Retry** button.
- **Subsequent page failure** → inline banner at the bottom of the list with a **Retry** button (existing posts remain visible).

---

## AI Chatbot Integration

### Architecture

```
ChatView
    └── ChatViewModel (@StateObject)
            └── AIService (injected via AIServiceProtocol)
                    └── POST https://api.openai.com/v1/chat/completions
```

`AIServiceProtocol` allows `AIService` to be swapped with a mock in unit tests.

### OpenAI Model

```swift
private let model = "gpt-4o-mini"
```

### Message Array Construction

Every API call sends the **full conversation history** prefixed with the system prompt:

```swift
var openAIMessages: [OpenAIMessage] = [
    OpenAIMessage(role: "system", content: AIService.systemPrompt)
]
// Append all user + assistant turns (system messages in local history are filtered out)
openAIMessages += messages.filter { $0.role != .system }
                          .map { OpenAIMessage(role: $0.role.rawValue, content: $0.content) }
```

This gives the model full context of the conversation on every turn.

### Request Parameters

| Parameter | Value |
|---|---|
| `model` | `gpt-4o-mini` |
| `temperature` | `0.7` |
| `max_tokens` | `512` |
| `timeout` | `60 s` |

### ChatViewModel State

| Property | Purpose |
|---|---|
| `messages: [ChatMessage]` | Full conversation history (persisted in memory) |
| `isLoading: Bool` | Shows typing indicator, disables send button |
| `errorMessage: String?` | Shown in a dismissible banner; user message removed on failure so they can retry |

---

## Healthcare-Only Restriction

### Implementation: System Prompt

The chatbot is restricted to healthcare topics using a **system prompt** injected at the start of every API request. There is no keyword blocklist, no post-processing filter, and no hardcoded question matching.

The `system`-role message is the **first** message in every request array:

```swift
var openAIMessages: [OpenAIMessage] = [
    OpenAIMessage(role: ChatRole.system.rawValue, content: AIService.systemPrompt)
]
```

### The System Prompt

```
You are a healthcare information assistant.

Your sole purpose is to answer healthcare-related questions with accurate,
general educational information. You may address:
• Diseases and medical conditions
• Symptoms and their possible causes
• Prevention and healthy habits
• Nutrition and fitness
• Medications (general information only)
• Medical terminology
• Mental health awareness
• General wellness

Rules:
1. Do NOT diagnose users or recommend specific treatments.
2. Do NOT claim to replace a qualified doctor or medical professional.
3. For any emergency, immediately advise the user to call emergency services
   or visit the nearest healthcare facility.
4. If a question is unrelated to healthcare, respond exactly with:
   "I'm designed to assist with healthcare-related information only.
   Please ask a healthcare-related question."
5. Keep responses clear, empathetic, and concise.
```

### Why System Prompt Over Alternatives

| Approach | Problem |
|---|---|
| Keyword blocklist | Brittle, easily bypassed, blocks valid health questions |
| Post-processing filter | Model generates the bad response first; adds latency |
| Client-side intent classifier | Extra model call; still misses edge cases |
| **System prompt (chosen)** | Model refuses before generating content; handles nuance |

The system prompt delegates the restriction decision to the model's own language understanding, which correctly handles ambiguous phrasing. For example: *"what should I eat?"* is resolved as a nutrition/wellness question (allowed) rather than a cooking query (blocked).

### Files Involved

| File | Role |
|---|---|
| `Services/AIService.swift` | Defines `systemPrompt`; builds and sends the OpenAI request |
| `ViewModels/ChatViewModel.swift` | Manages conversation state; calls `AIService.sendMessage(messages:)` |
| `Models/ChatMessage.swift` | Defines `ChatRole` enum (`.system`, `.user`, `.assistant`) and OpenAI Codable models |

### Limitation

Prompt-level restrictions can be bypassed by adversarial "jailbreak" prompts. For a production release, add the **OpenAI Moderation API** as a pre-send filter, or proxy all requests through a backend that applies server-side guardrails.

---

## Security Notes

- `OPENAI_API_KEY` is never hardcoded in source. It is injected via `Secrets.xcconfig` → `Info.plist` → `Bundle.main.infoDictionary` at runtime.
- `Secrets.xcconfig` is git-ignored and must be populated locally by each developer.
- For production, route OpenAI requests through a backend proxy so the key never appears in the compiled `.ipa`.
- Firebase ID tokens are short-lived (1 hour) and are automatically refreshed by the Firebase SDK.

---

## Home Page API Response Handling

> **Status:** The live WaveIn API (`POST /api/Post/home`) is not yet returning valid responses for the Home Page. Hardcoded JSON responses are used in their place so the UI can be built, tested, and demonstrated independently of the backend.

### Implementation

`PostListViewModel` is initialised with `MockPostService` as its default service:

```swift
init(
    postService: PostServiceProtocol = MockPostService(),
    authManager: FirebaseAuthManager = .shared
)
```

`MockPostService` (`Services/MockPostService.swift`) conforms to `PostServiceProtocol` and decodes one of three static JSON strings based on the requested page number, returning a fully-typed `FeedData` object — identical to what the real `PostService` would return.

| Page requested (`nextPage`) | JSON constant | Posts returned |
|---|---|---|
| 1 | `MockPostService.page1` | 20 posts |
| 2 | `MockPostService.page2` | 20 posts |
| 3 | `MockPostService.page3` | 20 posts |
| > 3 | — | Empty feed, `hasMorePages = false` |

The JSON is structured to match the real API response schema exactly (`HealthData → FeedData → [Feed]`), so switching to `PostService` (the live implementation) requires only changing the default argument in `PostListViewModel.init`.

---

### Media Support

The WaveIn API returns media URLs in two distinct formats:

| Media type | URL format in API response | Status |
|---|---|---|
| **Video** (`mediaType: 3`) | Absolute HTTPS URL (e.g. `https://wavedinblobs.blob.core.windows.net/…/master.m3u8`) | ✅ **Working** |
| **Image** (`mediaType: 2`) | Relative path (e.g. `userId/filename.jpg`) | ❌ Not supported — server URLs are invalid |
| **Audio** (`mediaType: 4`) | Relative path (e.g. `userId/filename.m4a`) | ❌ Not supported — server URLs are invalid |
| **PDF** (`mediaType: 5`) | Relative path (e.g. `userId/filename.pdf`) | ❌ Not supported — server URLs are invalid |

`APIClient.fullMediaURL(from:)` automatically detects whether a path is absolute or relative:

```swift
static func fullMediaURL(from path: String?) -> URL? {
    guard let path = path, !path.isEmpty else { return nil }
    if path.hasPrefix("http://") || path.hasPrefix("https://") {
        return URL(string: path)          // Absolute — used as-is (videos)
    }
    return URL(string: mediaBaseURL + path)  // Relative — prepend blob base URL
}
```

Although relative paths are correctly prefixed with the blob storage base URL, the resulting constructed URLs for images, audio, and PDFs do not resolve to valid resources on the server at this time. These media types are therefore **not rendered** in the current build.

#### Video Playback

Video posts use HLS streaming (`.m3u8` manifests hosted on Azure Blob Storage). Example working URL:

```
https://wavedinblobs.blob.core.windows.net/wavedinblobs/Videos/6a5a0eed7b8bd9b898c844e2/1784287396794/master.m3u8
```

Videos play correctly on the Home Page via `VideoPostView` using `AVPlayer` / `AVKit`.

---

```swift
// Before — incorrect for HLS: always returns empty tracks before playback
let tracks = try await asset.loadTracks(withMediaType: .video)
if tracks.isEmpty { loadFailed = true }

// After — correct: observes actual player item failure
item.publisher(for: \.status)
    .receive(on: DispatchQueue.main)
    .sink { status in
        if status == .failed { loadFailed = true }
    }
```

The observer is stored in an `@State private var statusObserver: AnyCancellable?` and cancelled in `onDisappear` to prevent retain cycles.

---

### Switching to the Live API

When the live API is ready, replace the default service in `PostListViewModel`:

```swift
// Current (mock data)
init(postService: PostServiceProtocol = MockPostService(), ...)

// Switch to live API — one-line change
init(postService: PostServiceProtocol = PostService(), ...)
```
