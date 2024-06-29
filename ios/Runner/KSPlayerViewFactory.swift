//
//  KSPLayerViewFactory.swift
//  Runner
//
//  Created by Aakash Sinha on 26/06/24.
//

import Foundation
import Flutter
import UIKit

class KSPLayerViewFactory: NSObject, FlutterPlatformViewFactory {
    private var messenger: FlutterBinaryMessenger
    
    init(messenger: FlutterBinaryMessenger) {
        self.messenger = messenger
        super.init()
    }
        public func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
      return FlutterStandardMessageCodec.sharedInstance()
}

    func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
    ) -> FlutterPlatformView {
        return KSPLayerView(frame: frame, viewIdentifier: viewId, arguments: args, binaryMessenger: messenger)
    }
}
