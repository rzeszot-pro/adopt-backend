//
//  Created by Damian Rzeszot on 08/10/2020.
//

import Vapor

extension ErrorMiddleware {
    private struct Payload: Codable {
        let status: String
        let reason: String
    }

    static func adopt(environment: Environment) -> ErrorMiddleware {
        .init { req, error in
            let status: HTTPResponseStatus
            let reason: String
            let headers: HTTPHeaders

            switch error {
            case let abort as AbortError:
                reason = abort.reason
                status = abort.status
                headers = abort.headers
            default:
                reason = environment.isRelease ? "Something went wrong." : String(describing: error)
                status = .internalServerError
                headers = [:]
            }

            req.logger.report(error: error)

            let response = Response(status: status, headers: headers)

            do {
                let paylaod = Payload(status: "error", reason: reason)
                response.body = try .init(data: JSONEncoder().encode(paylaod))
                response.headers.replaceOrAdd(name: .contentType, value: "application/json; charset=utf-8")
            } catch {
                response.body = .init(string: "Oops: \(error)")
                response.headers.replaceOrAdd(name: .contentType, value: "text/plain; charset=utf-8")
            }
            return response
        }
    }
}
