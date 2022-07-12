//
//  FileUploader.swift
//  BrightUploaderPOC
//
//  Created by Alex Maggio on 12/07/2022.
//

import Foundation

class FileUploader {
    typealias EndAction = (Bool, Data?) -> ()
    
    private var session = URLSession(configuration: .default)
    
    func uploadFile(fileName: String, to: URL, action: FileUploader.EndAction?) {
        var aRequest = URLRequest(url: to)
        aRequest.httpMethod = "POST"
        let task =
        session
            .uploadTask(
                with: aRequest,
                fromFile: URL(fileURLWithPath: fileName)) { d, r, e in
            guard let data = d,
                  let response = r
            else {
                print(e!)
                action?(false, nil)
                return
            }
            
            action?(true, data)
        }
        
        task.resume()
    }
}
