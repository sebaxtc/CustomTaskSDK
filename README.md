# Rick&MortySDK

<!-- INSTALLATION -->
## Installation

For instructions how to add a Swift package to your projects look here:

[Apple - Adding package dependencies to your app](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app)


<!-- USAGE EXAMPLES -->
## Usage

Example to get all characters as an array of character struct:

**1. Init Rick_MortySDK:**
```swift
let client = Rick_MortySDK()
```

**2. Call an SDK method for example: getAllCharacters**
```swift
 var cancellable: AnyCancellable?
 cancellable = client.getAllCharacters()
            .sink(receiveCompletion: { _ in }, receiveValue: { characters in
                characters.forEach() { print ($0.name) }
            })
```
