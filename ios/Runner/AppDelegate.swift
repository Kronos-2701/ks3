import UIKit
import Flutter
import flutter_downloader
import FirebaseCore
import Firebase
import FirebaseMessaging

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    weak var screen : UIView? = nil
var blurEffectView: UIVisualEffectView?  // Define blurEffectView at the class level

    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {    

    setUpBlurEffectView()
    FirebaseApp.configure()
      NotificationCenter.default.addObserver(self, selector: #selector(toggleScreenBlurForCapture), name: UIScreen.capturedDidChangeNotification, object: nil)
         window?.makeSecure()
      if let registrar = self.registrar(forPlugin: "KSPlayerPlugin") {
                let factory = KSPLayerViewFactory(messenger: registrar.messenger())
                registrar.register(factory, withId: "KSPLayerView")
            } else {
                
                print("Error: Could not find registrar")
            }
    GeneratedPluginRegistrant.register(with: self)
    FlutterDownloaderPlugin.setPluginRegistrantCallback(registerPlugins)
      if #available(iOS 10.0, *) {
  UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
}
   return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }


//for notifications
override func application(_ application: UIApplication,
  didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

   Messaging.messaging().apnsToken = deviceToken
   print("Token: \(deviceToken)")
   super.application(application,
   didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
 }



  func setUpBlurEffectView() {
        let blurEffect = UIBlurEffect(style: .regular)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView?.frame = window?.bounds ?? UIScreen.main.bounds
        blurEffectView?.isHidden = true
        window?.addSubview(blurEffectView!)
    }


@objc func toggleScreenBlurForCapture() {
        let isCaptured = UIScreen.main.isCaptured
        blurEffectView?.isHidden = !isCaptured
    }




  
}

  extension UIWindow {
   func makeSecure() {
        let field = UITextField()
        let view = UIView(frame: CGRect(x: 0, y: 0, width: field.frame.self.width, height: field.frame.self.height))
        field.isSecureTextEntry = true
        self.addSubview(field)
        self.layer.superlayer?.addSublayer(field.layer)
        field.layer.sublayers?.last!.addSublayer(self.layer)
        field.leftView = view
        field.leftViewMode = .always
    }

}

private func registerPlugins(registry: FlutterPluginRegistry) {
    if (!registry.hasPlugin("FlutterDownloaderPlugin")) {
       FlutterDownloaderPlugin.register(with: registry.registrar(forPlugin: "FlutterDownloaderPlugin")!)
    }
}
