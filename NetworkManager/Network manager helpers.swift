//
//  File.swift
//
//
//  Created by Ruben Nahatakyan on 7/28/20.
//

import Alamofire
import Foundation

// MARK: - Request result
public enum NetworkManagerResult<T: Codable> {
    case success(T)
    case failure(NetworkManagerError)
}

// MARK: - Parameter encoding
public enum RequestEncodingTypeEnum {
    case applicationJson
    case query
    case `default`

    var getEncodingType: ParameterEncoding {
        switch self {
        case .applicationJson: return JSONEncoding.default
        case .query: return URLEncoding.queryString
        case .`default`: return URLEncoding.default
        }
    }
}

// MARK: - Error type
public enum NetworkManagerError {
    case noConnection
    case cancelled
    case serverError
    case authorizationError
    case wrongResponseModel(error: Error, response: NSString)
    case unknownError(code: Int?)
    case custom(message: String)

    public var message: String {
        switch self {
        case .noConnection:
            return "no_internet_connetion"
        case .unknownError, .cancelled:
            return "unknown_error"
        case .serverError:
            return "unknown_error"
        case .custom(let message):
            return message
        case .authorizationError:
            return "authorization_error"
        case .wrongResponseModel:
            #if DEBUG
                return "wrong_response_model"
            #else
                return "unknown_error"
            #endif
        }
    }

    public var needRetry: Bool {
        switch self {
        case .noConnection, .serverError:
            return true
        default:
            return false
        }
    }

    public static func getError(_ value: Int?) -> NetworkManagerError {
        guard let code = value else {
            return .unknownError(code: value)
        }
        switch code {
        case -1009, -1001, -1005, 13:
            return .noConnection
        case -999:
            return .cancelled
        case 500...599:
            return .serverError
        case 401:
            return .authorizationError
        default:
            return .unknownError(code: value)
        }
    }
}

// MARK: - Upload type
public enum UploadFileTypeEnum {
    case photo
    case video
    case file

    var `extension`: String {
        switch self {
        case .photo: return ".jpg"
        case .video: return ".mov"
        case .file: return ".pdf"
        }
    }

    var mimeType: String {
        switch self {
        case .photo: return "image/jpg"
        case .video: return "video/quicktime"
        case .file: return "application/pdf"
        }
    }

    var name: String {
        switch self {
        case .photo: return "Attachment_"
        case .video: return "Image_"
        case .file: return "Video_"
        }
    }
}

// MARK: - Request method
public enum RequestMethod {
    case get
    case post
    case put
    case delete

    var AFMethod: HTTPMethod {
        switch self {
        case .get: return HTTPMethod.get
        case .post: return HTTPMethod.post
        case .put: return HTTPMethod.put
        case .delete: return HTTPMethod.delete
        }
    }
}
