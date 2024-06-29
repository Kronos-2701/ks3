import Flutter
import UIKit
import KSPlayer

public class KSPLayerView: NSObject, FlutterPlatformView {
    private var _view: UIView
    private var playerView: IOSVideoPlayerView?
    private var videoUrl: String?

    init(frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?, binaryMessenger: FlutterBinaryMessenger) {
        _view = UIView(frame: frame)
        super.init()
        
        if let args = args as? [String: Any], let videoUrl = args["videoUrl"] as? String {
            self.videoUrl = videoUrl
        }

        setupPlayer()
    }

    public func view() -> UIView {
        return _view
    }

    private func setupPlayer() {
        playerView = IOSVideoPlayerView()
        guard let playerView = playerView else { return }

        _view.addSubview(playerView)
        playerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: _view.topAnchor),
            playerView.leftAnchor.constraint(equalTo: _view.leftAnchor),
            playerView.rightAnchor.constraint(equalTo: _view.rightAnchor),
            playerView.bottomAnchor.constraint(equalTo: _view.bottomAnchor),
        ])

        // Set the player URL and resource without options
        KSOptions.canBackgroundPlay = false
        KSOptions.logLevel = .debug
        KSOptions.firstPlayerType = KSMEPlayer.self
        KSOptions.secondPlayerType = KSMEPlayer.self
        KSOptions.isAutoPlay = true
    
        KSOptions.isSecondOpen = true
        KSOptions.isAccurateSeek = true
        let options = KSOptions()

        if let videoUrl = videoUrl, let url = URL(string: videoUrl) {
            // playerView.set(url: url, options: options)
            playerView.set(resource: KSPlayerResource(url: url, options:options))
        } else {
            print("Invalid video URL")
        }
    }
}
