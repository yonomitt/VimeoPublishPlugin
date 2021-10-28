//
//  VimeoAPI.swift
//  
//
//  Created by Yonatan Mittlefehldt on 2021-24-10.
//

import Foundation

#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

struct VimeoAPI {
    enum Endpoint: String {
        case metadata = "https://vimeo.com/api/oembed.json"
    }

    enum EndpointError: Error {
        case badStatus(Int)
        case couldNotDecodeData(Error)
        case invalidBaseURL
        case invalidVideoURL
        case invalidURL
        case noData
        case requestFailed(Error)
        case timeout
        case unexpectedResponse
    }

    static func metadata(for videoURL: String) throws -> VimeoVideoMetadata {
        guard let url = URL(string: videoURL) else {
            throw EndpointError.invalidVideoURL
        }

        guard var components = URLComponents(string: Endpoint.metadata.rawValue) else {
            throw EndpointError.invalidBaseURL
        }

        components.queryItems = [
            URLQueryItem(name: "url", value: url.absoluteString)
        ]

        guard let apiURL = components.url else {
            throw EndpointError.invalidURL
        }

        var result: Result<VimeoVideoMetadata, EndpointError> = .failure(.timeout)
        let sema = DispatchSemaphore(value: 0)
        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: apiURL) { data, response, error in
            defer {
                sema.signal()
            }

            if let error = error {
                result = .failure(.requestFailed(error))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                result = .failure(EndpointError.unexpectedResponse)
                return
            }

            guard response.statusCode == 200 else {
                result = .failure(EndpointError.badStatus(response.statusCode))
                return
            }

            guard let data = data else {
                result = .failure(.noData)
                return
            }

            do {
                let decoder = JSONDecoder()
                let meta = try decoder.decode(VimeoVideoMetadata.self, from: data)
                result = .success(meta)
            } catch {
                result = .failure(.couldNotDecodeData(error))
            }
        }

        task.resume()

        _ = sema.wait(timeout: .now() + 15)

        switch result {
        case .success(let meta):
            return meta
        case .failure(let error):
            throw error
        }
    }
}
