//
//  MultiPartFormData.swift
//  Orbweaver
//
//  Created by Dario on 12/08/2022.
//

import Foundation

public struct MultiPartFormData {
    public init(url: URL) {
        self.url = url
    }

    public func addTextField(named name: String, value: String) {
        httpBody.append(textFormField(named: name, value: value))
    }


    public func addDataField(named name: String, data: Data, mimeType: String) {
        httpBody.append(dataFormField(named: name, data: data, mimeType: mimeType))
    }


    public var asURLRequest: URLRequest {
        var request = URLRequest(url: url)

        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        httpBody.append("--\(boundary)--")
        request.httpBody = httpBody as Data
        return request
    }


    // MARK: - Private Section -
    private let boundary: String = UUID().uuidString
    private var httpBody = NSMutableData()
    private let url: URL

     private func textFormField(named name: String, value: String) -> String {
        var fieldString = "\r\n--\(boundary)\r\n"
        fieldString += "Content-Disposition: form-data; name=\"\(name)\"\r\n"
        fieldString += "\r\n"
        fieldString += "\(value)\r\n"

        return fieldString
    }


    private func dataFormField(named name: String, data: Data, mimeType: String) -> Data {
        var fileData = Data()

        fileData.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        fileData.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(name).jpg\"\r\n".data(using: .utf8)!)
        fileData.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
        fileData.append(data)

        return fileData
    }
}
