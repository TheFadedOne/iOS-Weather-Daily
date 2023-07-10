//
//  Replaykit-Extension.swift
//  WeatherDaily
//
//  Created by Blackwell, Andrew on 7/3/23.
//

import Foundation
import SwiftUI
import ReplayKit

extension View {
    
    // MARK: Start Recording
    func startRecording(enableMicrophone: Bool = false, completion: @escaping (Error?)->()) {
        let recorder = RPScreenRecorder.shared()
        
        recorder.isMicrophoneEnabled = false
        
        recorder.startRecording(handler: completion)
    }
    
    func stopRecording() async throws -> URL {
        
        let name = UUID().uuidString + ".mov"
        let url = FileManager.default.temporaryDirectory.appendingPathComponent(name)
        
        let recorder = RPScreenRecorder.shared()
        
        try await recorder.stopRecording(withOutput: url)
        
        return url
    }
}
