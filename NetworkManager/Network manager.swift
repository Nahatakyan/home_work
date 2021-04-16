//
//  NetworkManager.swift
//
//  Created by Ruben Nahatakyan on 7/28/20.
//

import Alamofire
import Foundation

open class NetworkManager: NSObject {
    // MARK: - Properties
    private var baseUrl: String = ""
    private let sessionManager = Session.default

    public static let shared = NetworkManager()

    // MARK: - Init
    override private init() {
        super.init()
    }
}

// MARK: - Request
public extension NetworkManager {
    @discardableResult
    func request<T: Codable>(method: HTTPMethod, endpoint: String, params: NSDictionary? = nil, encoding: RequestEncodingTypeEnum = .default, headers: HTTPHeaders, result: @escaping (NetworkManagerResult<T>) -> Void) -> DataRequest? {
        let url = baseUrl + endpoint
        let parameters = params as? Parameters

        let request = sessionManager.request(url, method: method, parameters: parameters, encoding: encoding.getEncodingType, headers: headers).responseJSON { (response) -> Void in
            self.getJsonResponse(jsonResponse: response, result: result)
        }

        return request
    }

    @discardableResult
    func formDataRequest<T: Codable>(method: HTTPMethod = .post, endpoint: String, params: NSDictionary? = nil, headers: HTTPHeaders, result: @escaping (NetworkManagerResult<T>) -> Void) -> DataRequest? {
        let url = baseUrl + endpoint

        let request = AF.upload(multipartFormData: { multipartFormData in
            if let params = params {
                for (key, value) in params {
                    guard let data = "\(value)".data(using: String.Encoding.utf8) else { continue }
                    multipartFormData.append(data, withName: key as? String ?? "")
                }
            }
        }, to: url, method: method, headers: headers).responseJSON { responseResult in
            self.getJsonResponse(jsonResponse: responseResult, result: result)
        }
        return request
    }

    @discardableResult
    func upload<T: Codable>(method: HTTPMethod = .post, endpoint: String, params: NSDictionary? = nil, files: (name: String, data: [Data]), fileType: UploadFileTypeEnum, headers: HTTPHeaders, result: @escaping (NetworkManagerResult<T>) -> Void) -> DataRequest? {
        let url = baseUrl + endpoint

        let request = AF.upload(multipartFormData: { multipartFormData in
            if let params = params {
                for (key, value) in params {
                    guard let data = "\(value)".data(using: String.Encoding.utf8) else { continue }
                    multipartFormData.append(data, withName: key as? String ?? "")
                }
            }

            // Append files
            for data in files.data {
                self.attachDataToMultipart(file: data, withName: files.name, multipartFormData: multipartFormData, fileType: fileType)
            }
        }, to: url, method: method, headers: headers).responseJSON { responseResult in
            self.getJsonResponse(jsonResponse: responseResult, result: result)
        }
        return request
    }
}

// MARK: - Actions
private extension NetworkManager {
    func getJsonResponse<T: Codable>(jsonResponse: AFDataResponse<Any>, result: @escaping (NetworkManagerResult<T>) -> Void) {
        switch jsonResponse.result {
        case .success(let value):
            guard let jsonData = try? JSONSerialization.data(withJSONObject: value, options: .prettyPrinted) else {
                let serverError = NetworkManagerError.getError(jsonResponse.response?.statusCode)
                result(NetworkManagerResult.failure(serverError))
                return
            }
            do {
                let responseData = try JSONDecoder().decode(ResponseModel<T?>.self, from: jsonData)
                if responseData.success, let model = responseData.response, let data = model {
                    result(NetworkManagerResult.success(data))
                } else {
                    result(NetworkManagerResult.failure(NetworkManagerError.custom(message: responseData.error?.message ?? "unknown_error")))
                }
            } catch {
                debugPrint("Error parsing response data to JSON: \(error)")
                result(NetworkManagerResult.failure(NetworkManagerError.wrongResponseModel(error: error, response: jsonData.text)))
            }
        case .failure(let error as NSError):
            let code = jsonResponse.response?.statusCode ?? error.code
            let serverError = NetworkManagerError.getError(code)
            result(NetworkManagerResult.failure(serverError))
        }
    }

    func attachDataToMultipart(file: Data?, withName: String, multipartFormData: MultipartFormData, fileType: UploadFileTypeEnum) {
        guard let data = file else { return }
        let name = "\(fileType.name)\(UUID().uuidString)" + fileType.extension
        multipartFormData.append(data, withName: withName, fileName: name, mimeType: fileType.mimeType)
    }

    enum ResponseJsonErrorType: Error {
        case wrongJson
        case wrongResponseModel
    }
}

// MARK: - Public methods
public extension NetworkManager {
    // MARK: Base url
    func setBaseUrl(_ baseUrl: String) {
        self.baseUrl = baseUrl
    }
}
