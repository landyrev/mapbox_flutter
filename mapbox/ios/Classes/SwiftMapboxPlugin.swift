import Flutter
import UIKit

public class SwiftMapboxPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let factory = ChartNativeViewFactory(messenger: registrar.messenger())
        registrar.register(factory, withId: "ChartNativeView")
        
        let channel = FlutterMethodChannel(name: "mapbox", binaryMessenger: registrar.messenger())
        let instance = SwiftMapboxPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result("iOS " + UIDevice.current.systemVersion)
    }
}
