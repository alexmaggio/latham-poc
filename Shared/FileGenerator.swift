//
//  FileGenerator.swift
//  BrightUploaderPOC
//
//  Created by Alex Maggio on 12/07/2022.
//

import Foundation

class FileGenerator {
    typealias UpdateAction = (Double) -> ()
    
    func writeDataToFile(file: String, size: Int = 2.gb, updateAction: UpdateAction? = nil) -> String {

        guard size > 0 else {
            return ""
        }
        
        let documentsPath = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])
        guard let logsPath = documentsPath.appendingPathComponent("POCTests") else {
            return ""
        }
        
        do {
            try FileManager.default.createDirectory(
                atPath: logsPath.path,
                withIntermediateDirectories: true,
                attributes: nil
            )
        } catch {
            print("Unable to create directory. Error: \(error)")
            return ""
        }

        var str: String = ""
        for idx in 0 ..< size {
            str += String("\(idx % 10)")
            let progress = (Double(idx) * Double(100)/Double(size))
            updateAction?(progress * 0.8)
        }
        
        let fileName = logsPath.appendingPathComponent(file + ".txt")

        do{
            try str.write(
                to: fileName,
                atomically: false,
                encoding: String.Encoding.utf8
            )
            updateAction?(Double(1))
            return fileName.absoluteString
        } catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
            return ""
        }
    }
}
