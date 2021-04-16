//
//  Request service.swift
//  Grand Candy
//
//  Created by Ruben Nahatakyan on 6/1/20.
//  Copyright © 2020 Ruben Nahatakyan. All rights reserved.
//

import Alamofire
import Foundation

public protocol RequestService {
    var path: String { get }
    var method: RequestMethod { get }
    var params: NSDictionary? { get }
    var encoding: RequestEncodingTypeEnum { get }
    var headers: [String: String] { get }
    func errorResponse(_ error: NetworkManagerError)
}

public extension RequestService {
    @discardableResult
    func request<T: Codable>(result: @escaping (NetworkManagerResult<T>) -> Void) -> DataRequest? {
        let request = NetworkManager.shared.request(method: method.AFMethod, endpoint: path, params: params, encoding: encoding, headers: HTTPHeaders(headers)) { (response: NetworkManagerResult<T>) in
            switch response {
            case .success: break
            case .failure(let error):
                self.errorResponse(error)
            }
            result(response)
        }
        return request
    }

    @discardableResult
    func formDataRequest<T: Codable>(result: @escaping (NetworkManagerResult<T>) -> Void) -> DataRequest? {
        let request = NetworkManager.shared.formDataRequest(method: method.AFMethod, endpoint: path, params: params, headers: HTTPHeaders(headers)) { (response: NetworkManagerResult<T>) in
            switch response {
            case .success: break
            case .failure(let error):
                self.errorResponse(error)
            }
            result(response)
        }
        return request
    }

    @discardableResult
    func upload<T: Codable>(files: (name: String, data: [Data]), fileType: UploadFileTypeEnum, result: @escaping (NetworkManagerResult<T>) -> Void) -> DataRequest? {
        let request = NetworkManager.shared.upload(method: method.AFMethod, endpoint: path, params: params, files: files, fileType: fileType, headers: HTTPHeaders(headers)) { (response: NetworkManagerResult<T>) in
            switch response {
            case .success: break
            case .failure(let error):
                self.errorResponse(error)
            }
            result(response)
        }
        return request
    }
}
