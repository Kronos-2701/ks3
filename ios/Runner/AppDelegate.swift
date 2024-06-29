import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
  GeneratedPluginRegistrant.register(with: self)
        
           
        // Register the custom Flutter platform view
        if let registrar = self.registrar(forPlugin: "KSPlayerPlugin") {
            let factory = KSPLayerViewFactory(messenger: registrar.messenger())
            registrar.register(factory, withId: "KSPLayerView")
        } else {
            
            print("Error: Could not find registrar")
        }
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
