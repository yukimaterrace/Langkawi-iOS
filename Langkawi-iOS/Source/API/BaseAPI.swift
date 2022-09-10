//
//  BaseAPI.swift
//  Langkawi-iOS
//
//  Created by Yuki Matsuo on 2022/08/31.
//

import Foundation
import Alamofire
import Combine

class BaseAPI: SwinjectSupport {
    
    private let apiPath = "http://localhost:3000/api"
    
    private lazy var globalExceptionHandler = resolveInstance(GlobalExceptionHandler.self)
    
    func request<T: Decodable>(
        vc: UIViewController,
        path: String,
        model: T.Type,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        errorHandler: ((Error) -> Bool)? = nil,
        responseHandler: @escaping (T) -> Void
    ) -> AnyCancellable {
        return AF.request("\(apiPath)\(path)", method: method, parameters: parameters, headers: headers).publishData()
            .map { (dr: DataResponse<Data, AFError>) -> Result<T, Error> in
                switch dr.result {
                case .success(let data):
                    guard let status = dr.response?.statusCode else {
                        return .failure(AFError.responseSerializationFailed(reason: .invalidEmptyResponse(type: "empty")))
                    }
                    
                    do {
                        let decoder = JSONDecoder()
                        if status == 200 {
                            return .success(try decoder.decode(model, from: data))
                        } else {
                            let resp = try decoder.decode(ErrorResponse.self, from: data)
                            return .failure(APIStatusError(status: status, response: resp))
                        }
                    } catch {
                        return .failure(AFError.responseSerializationFailed(reason: .decodingFailed(error: error)))
                    }
                case .failure(let error):
                    return .failure(error)
                }
            }.sink { [weak self, weak vc] in
                switch $0 {
                case .success(let response):
                    responseHandler(response)
                case .failure(let error):
                    var cont = true
                    if let errorHandler = errorHandler {
                        cont = errorHandler(error)
                    }
                    if cont {
                        self?.globalExceptionHandler.handle(error: error, vc: vc)
                    }
                }
            }
    }
}
