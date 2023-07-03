# AppStorage/UserDefaults
## Ideal for storing small amounts of information.

## What is AppStorage/UserDefaults
`@AppStorage` is a property wrapper in SwiftUI that reflects the UserDefaults value.
```swift
@AppStorage("username") var name = ""

let otherName = UserDefaults.standard.string(forKey: "username")

// name == otherName
```

## When to use it?
UserDefaults is best used to store small pieces of information, for example, a user's username, or a settings configuration. 

While UserDefaults supports storing raw Data, it can lead to significant delay when retrieving data as the data would have to be embedded in a Property List file.

## Data Storage
It stores all data in a Property List (.plist) file within the app's sandbox. 

<img width="712" alt="A screenshot of the Property List with 3 values corresponding with AppStorage values in Xcode" src="https://github.com/jiachenyee/persistence-demo/assets/36725840/d2531329-4edf-449e-b6a8-0185710bd091">

When testing with the Simulator, you can open and inspect the file by filling the placeholders in this URL:
```
APP HOME DIRECTORY/Library/Preferences/BUNDLE_ID.plist
```
An example of the URL is:
```
/Users/jiachenyee/Library/Developer/CoreSimulator/Devices/09658336-07BE-494D-8CB0-64DB82FE35D6/data/Containers/Data/Application/DAC13411-85AE-4E7B-9601-158CD20A6833/Library/Preferences/app.jiachen.Todo.plist
```

Alternatively, to obtain the URL, you can print this line out when your view appears. It will provide you with the file path to the UserDefaults storage.
```swift
print("You can find the data here: \(NSHomeDirectory())/Library/Preferences/\(Bundle.main.bundleIdentifier!).plist")
```

## Further Reading
- [AppStorage — Apple Developer Documentation](https://developer.apple.com/documentation/swiftui/appstorage)
- [UserDefaults — Apple Developer Documentation](https://developer.apple.com/documentation/foundation/userdefaults)
- [How to save user settings using UserDefaults — Hacking with Swift](https://www.hackingwithswift.com/example-code/system/how-to-save-user-settings-using-userdefaults)
- [What is the @AppStorage property wrapper? — Hacking with Swift](https://www.hackingwithswift.com/quick-start/swiftui/what-is-the-appstorage-property-wrapper)
