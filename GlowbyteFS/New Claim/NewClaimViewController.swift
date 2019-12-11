////
////  NewClaimViewController.swift
////  GlowbyteFS
////
////  Created by Kirill on 02.12.2019.
////  Copyright © 2019 Kirill. All rights reserved.
////
//
//import UIKit
//import MapKit
//import CoreLocation
//import AVFoundation
//import ContactsUI
//
//class NewClaimViewController: UIViewController {
//
//    // MARK: - Incident Location
//    //IBOutlet weak var mapView: MKMapView!
//   // @IBOutlet weak var addressLabel: UILabel!
//
//    // MARK: - Incident Description
//    @IBOutlet weak var transcriptionTextView: UITextView!
//    @IBOutlet weak var recordingTimerLabel: UILabel!
//    @IBOutlet weak var playButton: UIButton!
//    @IBOutlet weak var recordButton: UIButton!
//
//    // MARK: - Photos of Damages
//    @IBOutlet weak var photoStackView: UIStackView!
//    @IBOutlet weak var photoStackHeightConstraint: NSLayoutConstraint!
//
//
//    // MARK: - New Claim properties
//    var wasSubmitted = false
//
//
//    var recordingSession: AVAudioSession!
//    var incidentRecorder: AVAudioRecorder?
//    var audioPlayer: AVAudioPlayer!
//    var meterTimer: Timer?
//    var transcribedText = ""
//    var isPlaying = false
//
//  //  var imagePickerCtrl: UIImagePickerController!
//  //  var selectedImages: [UIImage] = []
//
//    var contacts: [CNContact] = []
//    let contactPicker = CNContactPickerViewController()
//
//    var alert: UIAlertController!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        //Recording Setup
//        //initAVRecordingExtension()
//        self.transcriptionTextView.delegate = self
//
//    }
//
//    // MARK: - Actions
//    @IBAction func submitClaim(_ sender: UIBarButtonItem) {
//      // uploadClaimTransaction()
//    }
//
//    @IBAction func playPauseAudioTapped(_ sender: UIButton) {
//        toggleAudio()
//    }
//
//    @IBAction func startOrStopRecordingTapped(_ sender: UIButton) {
//        toggleRecording()
//    }
//
//    @IBAction func addPhotoTapped(_ sender: UIButton) {
//        //
//    }
//}
//
//extension NewClaimViewController: UITextViewDelegate {
//    func textViewDidEndEditing(_ textView: UITextView) {
//        self.transcribedText = self.transcriptionTextView.text
//    }
//}
//
////func requestForCreatingImageAttachment(
////       from image: UIImage,
////       relatingToCaseID caseID: String,
////       fileName: String? = nil) -> RestRequest {
////       let imageData = image.resizedByHalf().pngData()!
////       let uploadFileName = fileName ?? UUID().uuidString + ".png"
////       return self.requestForCreatingAttachment(from: imageData, withFileName: uploadFileName, relatingToCaseID: caseID)
////   }
