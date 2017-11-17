# Configurate

[![CocoaPods](https://img.shields.io/cocoapods/v/Configurate.svg)]() [![CocoaPods](https://img.shields.io/cocoapods/l/Configurate.svg)]() [![Travis](https://travis-ci.org/patgoley/Configurate.svg?branch=master)]() [![codecov](https://codecov.io/gh/patgoley/Configurate/branch/master/graph/badge.svg)]()

Configurate is a package for building layered `Config` objects, which are essentially stacks of key-value collections.
Configs are protocol based, so they can be implemented by any source that can provide a value for a given key.

## Example

```swift
let config = Config(ProcessInfo.processInfo)            // Searches environment variables
    .include(UserDefaults.standard)                     // Searches a UserDefaults instance
    .include(try! ConfigFile(url: URL("config.json")))  // Searches a JSON or Plist config file, must result in [String: Any]
    .include(["key": "overrideValue"])                  // Searches a [String: Any] Dictionary
    
let value: String? = config["someKey"]                  // Infers expected return type
```

The key value collections included in the `Config` are searched in reverse order, so that values from one collection override values from previously added collections.

## Installation

#### Swift Package Manager

```swift
import PackageDescription

let package = Package(
    name: "MyPackage",
    dependencies: [
        .Package(url: "https://github.com/patgoley/Configurate.git", majorVersion: 1),
    ]
)
```

#### Cocoapods

```ruby
pod 'Configurate', '~> 1.0'
```

## License

[MIT](LICENSE)
