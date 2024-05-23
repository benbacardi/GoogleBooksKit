# GoogleBooksKit

GoogleBooksKit is a Swift package for interacting with the Google Books APIs.

## Usage

Start by initialising a `GoogleBooks` instance. A valid API key must be providied:

```swift
import GoogleBooksKit

let client = GoogleBooks(apiKey: "")
```

### Searching

```swift
let searchTerm = "A Day of Fallen Night"
if let results = client.search(searchTerm) {
    print("Found \(results.totalItems) results.")
} else {
    print("No results.")
}
```
