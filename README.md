# DogFinder

A SwiftUI application for browsing and exploring dog breeds with detailed information fetched from The Dog API.

## Features

- Browse a list of dog breeds with their basic information
- Search functionality to filter dogs by name
- Real-time search filtering with smooth animations
- Light and dark mode toggle with persistent preference
- Loading states and error handling with retry functionality
- Clean and modern UI with SwiftUI
- Detailed dog view with comprehensive information
- Async image loading with error handling

## Architecture

The project demonstrates modern SwiftUI patterns and MVVM architecture:

### Model

**Dog** - Decodable model representing a single dog breed from The Dog API
- Includes id, name, bredFor, lifeSpan, temperament, origin, and image
- Contains nested Image struct with URL for breed images
- All properties except id, name, and lifeSpan are optional to handle missing JSON values gracefully
- Conforms to Decodable, Identifiable, and Hashable for JSON parsing and list operations
- Uses snake_case to camelCase conversion via JSONDecoder keyDecodingStrategy

**Dog.Image** - Nested struct representing dog breed image data
- Contains optional URL string for the breed image
- Conforms to Decodable and Hashable

### Service

**FetchService** - Fetches and decodes dog breed data from The Dog API
- Uses URLSession with async/await for network requests
- Custom error handling with NetworkError enum (invalidURL, badResponse)
- Fetches data from The Dog API v1 breeds endpoint
- Uses JSONDecoder with convertFromSnakeCase strategy for parsing API responses
- Requires API key authentication via x-api-key header
- Returns array of Dog objects directly from API response

### ViewModel

**DogListViewModel** - Manages application state and business logic
- Uses @Observable macro for reactive UI updates
- @MainActor for thread-safe UI updates
- Dependency injection via initializer (receives FetchService)
- Search functionality with case-insensitive filtering
- Loading and error state management
- Maps Dog domain models to DogViewModel presentation models

**DogViewModel** - Presentation model wrapping Dog
- Conforms to Identifiable and Hashable for SwiftUI list support
- Provides computed properties for view display with fallback values
- Handles optional dog properties with default values ("N/A" for strings)
- Separates domain model from presentation concerns
- Trims whitespace from origin values for clean UI display
- Converts image URL string to URL? for AsyncImage compatibility

### Views

**ContentView** - Main container with searchable dog list and dark mode toggle
- Uses @AppStorage for persistent dark mode preference
- Real-time search filtering with searchable modifier
- NavigationStack for navigation
- Loading, error, and content states with appropriate UI
- Toolbar button for theme switching
- Displays dog name in list view with custom styling
- Custom list row background and navigation bar styling

**DogDetailView** - Detailed view for individual dog breed information
- Scrollable detail view showing all dog properties
- Displays name, bred for, life span, temperament, and origin
- AsyncImage for loading breed images with loading and error states
- Clean layout with reusable infoRow helper method for consistent formatting
- Each information row uses a private helper function to eliminate code duplication
- Navigation title with dog name
- Custom background and navigation bar styling

## Dependency Injection

The project uses constructor-based dependency injection:

- DogListViewModel receives FetchService as a dependency through its initializer
- This allows for easy testing and swapping implementations
- FetchService is injected in ContentView when creating the ViewModel
- Promotes loose coupling and testability

## State Management

- @State for local view state (search text, ViewModel instance)
- @AppStorage for persistent dark mode preference
- @Observable macro for reactive ViewModel updates
- Reactive filtering with searchable modifier and computed properties

## Secrets Management

**Secrets.swift** - Provides access to API keys via Bundle info dictionary
- **Secrets.xcconfig** - Build configuration file storing API key securely
- API key stored in DOG_API_KEY build setting
- Fatal error if API key is missing to ensure proper configuration

## Technologies

- **SwiftUI** - Modern declarative UI framework
- **Async/Await** - Asynchronous data fetching from API using modern Swift concurrency
- **REST API** - Integration with The Dog API
- **NavigationStack** - Programmatic navigation
- **JSON Decoding** - Custom Decodable implementation with snake_case conversion
- **Searchable** - Built-in search functionality with real-time filtering
- **AppStorage** - Persistent user preferences for theme
- **Observable** - Using @Observable macro for reactive UI updates
- **Dependency Injection** - Constructor-based DI for testability and flexibility
- **Animation** - Smooth transitions with default SwiftUI animations
- **URLRequest** - Custom request configuration with API key header authentication
- **AsyncImage** - Asynchronous image loading with error handling

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+
- The Dog API key (configured in Secrets.xcconfig)

## Credits

This application uses The Dog API provided by The Dog API team. The API provides access to comprehensive dog breed data, allowing users to browse and explore dog breeds with detailed information including breed characteristics, temperament, origin, and images.

The Dog API enables access to extensive dog breed information, including breed details, life spans, breeding purposes, and high-quality breed images for educational and entertainment purposes.

For more information about the API and to obtain an API key, visit [thedogapi.com](https://thedogapi.com).
