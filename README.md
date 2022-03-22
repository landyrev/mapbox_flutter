# Flutter Mapbox
This repository is a minimal reproducible test case for the https://github.com/mapbox/mapbox-maps-ios/issues/1194 issue

## How to run it

1. Add Mapbox public key to the `app/ios/Runner/Info.plist` (key `MBXAccessToken` )
1. Install latest [Flutter SDK](https://docs.flutter.dev/get-started/install/macos)
2. Run `flutter pub get` inside the `./app` folder
3. Run `pod install` inside the `./app/ios` folder
4. Run iOS simulator or connect an iOS device
5. Run `flutter run`


## How to reproduce an issue
1. Tap on chart
2. Pan chart (chart not moving, pan gesture not recognized)
3. Pan chart again (now chart is movinc, pan gesture successfully recognized)


## How to fix an issue
### 1. Downgrade Mapbox SDK
Downgrade mapbox SDK to 10.2.0 version to fix this issue

mapbox/ios/mapbox.podspec:
```diff
- s.dependency 'MapboxMaps', '10.3.0'
+ s.dependency 'MapboxMaps', '10.2.0'
```

### 2. Patch Mapbox SDK
Modify the `/app/ios/Pods/MapboxMaps/Sources/MapboxMaps/Gestures/GestureRecognizers/AnyTouchGestureRecognizer.swift` in a following way:

```diff
override func canBePrevented(by preventingGestureRecognizer: UIGestureRecognizer) -> Bool {
-    return false
+    return true
}
```