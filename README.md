# Configurate

Configurate is a package for building layered `Config` objects, which are essentially stacks of key-value collections.
Configs are protocol based, so they can be implemented by any source that can provide a value for a given key.

## Example

```swift
let config = Config(ProcessInfo.processInfo)            // Searches environment variables
    .include(UserDefaults.standard)                     // Searches UserDefaults instance
    .include(try! ConfigFile(url: URL("config.json")))  // Searches JSON or Plist config file, must result in [String: Any] type
    .include(["key": "configValue"])                    // Searches a [String: Any] Dictionary
    
let value: String? = config["someKey"]                  // Infers expected return type
```

The key value collections included in the `Config` are searched in reverse order, so that values from one collection override values from previously added collections.
