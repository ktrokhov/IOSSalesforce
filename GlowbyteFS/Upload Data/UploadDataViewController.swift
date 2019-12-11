////
////  UploadDataViewController.swift
////  GlowbyteFS
////
////  Created by Kirill on 06.12.2019.
////  Copyright © 2019 Kirill. All rights reserved.
////
//
import SalesforceSDKCore
import UIKit
var CaseNumber: String?
var selectedImages: [UIImage] = []
var imagePickerCtrl: UIImagePickerController!

class UploadDataViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {



    @IBOutlet weak var ImageView: UIImageView!
    @IBAction func Done(_ sender: Any) {
                for (index, image) in selectedImages.enumerated() {
                    let attachmentRequest = RestClient.shared.requestForCreatingImageAttachment( from: image, relatingToCase: ourID!)
                    RestClient.shared.send(request: attachmentRequest, onFailure: handleError) { _, _ in
                        SalesforceLogger.d(
                            type(of: self),
                            message: "Completed upload of photo \(index + 1) of \(selectedImages.count)."
                        )
                    }
                }
                //self.uploadAudio(forCaseID: caseID)
         
         func handleError(_ error: Error?, urlResponse: URLResponse? = nil) {
                let errorDescription: String
                if let error = error {
                    errorDescription = "\(error)"
                } else {
                    errorDescription = "An unknown error occurred."
            }
        
                SalesforceLogger.e(type(of: self), message: "Failed to successfully complete the REST request. \(errorDescription)")
            }
        
        print("DOne????")
        guard let vc = storyboard?.instantiateViewController(identifier: "OpenClaimsTableViewController") as? OpenClaimsTableViewController else { return }
        navigationController?.viewControllers = [vc];(vc, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func chooseImage(_ sender: Any) {
        print("Test")

        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self

        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)

        }else{
            print("Camera not avaliable")
            }
        }))

        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {(action:UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))

        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        ImageView.image = image
        selectedImages.append(image)
        print(selectedImages.count)
        picker.dismiss(animated: true, completion: nil)
        guard (info[.originalImage] as? UIImage) != nil else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }

    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//           imagePickerCtrl.dismiss(animated: true, completion: nil)
//           // Make sure to leave this line intact. It helps us score the challenge
//           RestClient.shared.sendImagesSelectedInstrumentation()
//           if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
//               guard let caseId = caseId else {return}
//               let attachmentRequest = RestClient.shared.requestForCreatingImageAttachment(from: image, relatingTo: caseId)
//               RestClient.shared.send(request: attachmentRequest, onFailure: self.handleError){ result, _ in
//                   SalesforceLogger.d(type(of: self), message: "Completed upload of photo")
//               }
//           }
//       }
    
    
      private func handleError(_ error: Error?, urlResponse: URLResponse? = nil) {
            let errorDescription: String
            if let error = error {
                errorDescription = "\(error)"
            } else {
                errorDescription = "An unknown error occurred."
            }
            
            SalesforceLogger.e(type(of: self), message: "Failed to successfully complete the REST request. \(errorDescription)")
        }
    }



extension RestClient {
     private func uploadPhotos(forCaseID caseID: String) {
            for (index, image) in selectedImages.enumerated() {
                let attachmentRequest = RestClient.shared.requestForCreatingImageAttachment(from: image, relatingToCase: ourID!)
                RestClient.shared.send(request: attachmentRequest, onFailure: handleError) { _, _ in
                    SalesforceLogger.d(
                        type(of: self),
                        message: "Completed upload of photo \(index + 1) of \(selectedImages.count)."
                    )
                }
            }
            //self.uploadAudio(forCaseID: caseID)
        }
      private func handleError(_ error: Error?, urlResponse: URLResponse? = nil) {
            let errorDescription: String
            if let error = error {
                errorDescription = "\(error)"
            } else {
                errorDescription = "An unknown error occurred."
        }
    
            SalesforceLogger.e(type(of: self), message: "Failed to successfully complete the REST request. \(errorDescription)")
        }
    
}

    
//    private func uploadPhotos(forCaseID caseID: String) {
//        for (index, image) in selectedImages.enumerated() {
//            let attachmentRequest = RestClient.shared.requestForCreatingImageAttachment(from: image, relatingToCaseID: caseID)
//            RestClient.shared.send(request: attachmentRequest, onFailure: handleError) { _, _ in
//                SalesforceLogger.d(
//                    type(of: self),
//                    // message: "Completed upload of photo \(index + 1) of \(self.selectedImages.count)."
//                )
//            }
//        }
//    }
//    //var CaseID="0001035"
//   // self.uploadPhotos(forCaseID: CaseID)
//    
//}

//extension UploadDataViewController{
//   //var caseID = "0001035"
//    for (index, image) in selectedImages.enumerated() {
//        let attachmentRequest = RestClient.shared.requestForCreatingImageAttachment(from: image, relatingToCaseID: caseID)
//        RestClient.shared.send(request: attachmentRequest, onFailure: handleError) { _, _ in
//            SalesforceLogger.d(
//                type(of: self),
//                message: "Completed upload of photo \(index + 1) of \(self.selectedImages.count)."
//            )
//            }
//    }
//}

//
//extension UploadDataViewController {
//    private func handleError(_ error: Error?, urlResponse: URLResponse? = nil) {
//        let errorDescription: String
//        if let error = error {
//            errorDescription = "\(error)"
//        } else {
//            errorDescription = "An unknown error occurred."
//        }
//
//        SalesforceLogger.e(type(of: self), message: "Failed to successfully complete the REST request. \(errorDescription)")
//    }
//}

