import Flutter
import UIKit
import MapboxMaps

class ChartNativeViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger

    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return ChartNativeView(
            frame: frame,
            viewIdentifier: viewId,
            arguments: args,
            binaryMessenger: messenger)
    }
}

class ChartNativeView: NSObject, FlutterPlatformView {
    private var _view: MapView

    init(
        frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?,
        binaryMessenger messenger: FlutterBinaryMessenger?
    ) {
        var bounds = frame
        if (bounds.height == 0 || bounds.width == 0) {
            bounds = UIScreen.main.bounds
        }
        let token = Bundle.main.object(forInfoDictionaryKey: "MBXAccessToken") as! String
        let myResourceOptions = ResourceOptions(accessToken: token)
        let myMapInitOptions = MapInitOptions(resourceOptions: myResourceOptions)
        _view = MapView(frame: bounds, mapInitOptions: myMapInitOptions)
        _view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        super.init()
    }

    func view() -> UIView {
        return _view
    }
}
