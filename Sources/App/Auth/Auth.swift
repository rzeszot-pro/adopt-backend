//
//  File.swift
//  
//
//  Created by Damian Rzeszot on 08/10/2020.
//

import Foundation
import Vapor
import PostgresKit

public struct SignIn {

    struct Request: Content {
        let user: String
    }

    struct Response: Content {
        let uuid: UUID
    }

    public init() {

    }

    // MARK: -

    public func configure(app: Application) {
        let auth = app.grouped("auth")

        auth.post("sign-in") { req -> EventLoopFuture<Response> in
            let request = try req.content.decode(Request.self)

            let repository = PostgresUserRepository(postgres: req.postgress)
            let command = CreateUserCommand(email: request.user)
            let handler = CreateUserHandler(repository: repository)

            return handler
                .handle(command: command)
                .flatMapThrowing { Response(uuid: $0) }
        }
    }
}




//db.raw(" CREATE EXTENSION \"uuid-ossp\";").run().wait()
//
//try! db
//    .drop(table: "users")
//    .ifExists()
//    .run()
//    .wait()
//
//
//try! db
//    .create(table: "users")
//    .column("uuid", type: .custom(SQLRaw("UUID")), .custom(SQLRaw("DEFAULT uuid_generate_v4()")))
//    .column("email", type: .text, .unique)
//    .primaryKey("uuid")
//    .run()
//    .wait()
