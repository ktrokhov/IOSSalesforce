////
////  UploadDataViewController+Uploading.swift
////  GlowbyteFS
////
////  Created by Kirill on 06.12.2019.
////  Copyright © 2019 Kirill. All rights reserved.
////
//import SalesforceSDKCore
//import UIKit
//
//extension UploadDataViewController{
//   var caseID = "0001035"
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
