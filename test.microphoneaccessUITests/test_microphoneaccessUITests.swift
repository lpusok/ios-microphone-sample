//
//  test_microphoneaccessUITests.swift
//  test.microphoneaccessUITests
//
//  Created by lpusok on 2019. 06. 27..
//  Copyright © 2019. bitrise. All rights reserved.
//

import XCTest
import AVFoundation

class test_microphoneaccessUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
//          UITestHelper.resetAuthorisation(setToInUse: true)

//        addUIInterruptionMonitor(withDescription: "Access", handler: { (alert) -> Bool
//            in
//            if alert.buttons["OK"].exists {
//                alert.buttons["OK"].tap()
//            }
//            return true
//        })
        

        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        sleep(3)
        
        let springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        
        let allowBtn = springboard.buttons["OK"]
        if allowBtn.waitForExistence(timeout: 10) {
            allowBtn.tap()
        }
        
        sleep(1)
        

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    var recorder: AVAudioRecorder?
    
    func testRecording() {
        
        
        let recordExpectation = expectation(description: "Record")
        
        let recordSettings = [
            // AVFormatIDKey: NSNumber(unsignedInt:kAudioFormatLinearPCM),
            AVNumberOfChannelsKey: 1,
            AVSampleRateKey : 16000.0
        ]
        
        let dirsPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docsDir = dirsPaths[0] as String
        let soundFilePath = docsDir + "/test.wav"
        
        print("Saving recorded audio file in \(soundFilePath)")
//        AVAudioSession.sharedInstance().requestRecordPermission({(granted: Bool) -> Void
//            in
//            if granted {
                let soundFileURL = URL(string: soundFilePath)
                
                if let soundFileURL = soundFileURL {
                    do {
                        self.recorder = try AVAudioRecorder(url: soundFileURL, settings: recordSettings)
                        
                        self.recorder!.isMeteringEnabled = true
                        
                        print("Start recording")
//                         self.recorder.prepareToRecord()
                        self.recorder!.record(forDuration: 3.0)
                        print("Sleep")
                        sleep(5)
                        print("Sleep over")
                        
                        print(self.recorder!.isRecording)
                        
                        self.recorder!.stop()
                        
                        recordExpectation.fulfill()
                    } catch {
                            XCTAssertTrue(false, "Could not create audio recorder")
                    }
                }
//            } else {
//                XCTAssertTrue(false, "No mic permission")
//            }
//        })
        
        waitForExpectations(timeout: 50) {
                    error in XCTAssertNil(error, "Timeout")
        }
    }
    
    

}

