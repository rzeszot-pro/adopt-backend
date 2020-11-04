//
//  File.swift
//  
//
//  Created by Damian Rzeszot on 08/10/2020.
//

import Vapor
import PostgresKit

extension Request {
    var postgress: PostgresDatabase {
        application.wtf.postgress(logger: logger, on: eventLoop)
    }
}

extension Application {
    public var wtf: WTF {
        .init(application: self)
    }

    public struct WTF {
        let application: Application

        public func use(url: String) throws {
            try WhatTheFuck(application: application).use(url: url)
        }

        public func postgress(logger: Logger, on eventLoop: EventLoop) -> PostgresDatabase {
            WhatTheFuck(application: application).postgress(logger: logger, on: eventLoop)
        }
    }
}

private struct WhatTheFuck {
    let application: Application

    // MARK: -

    class Storage {
        var configuration: PostgresConfiguration!
        var source: PostgresConnectionSource!
        var pools: EventLoopGroupConnectionPool<PostgresConnectionSource>!
    }

    struct Key: StorageKey {
        typealias Value = Storage
    }

    var storage: Storage {
        if application.storage[Key.self] == nil {
            application.storage[Key.self] = .init()
        }
        return application.storage[Key.self]!
    }

    // MARK: -

    func use(url: String) throws {
        storage.configuration = PostgresConfiguration(url: url)
        storage.configuration.tlsConfiguration = .forClient(certificateVerification: .none)
        storage.source = PostgresConnectionSource(configuration: storage.configuration)
        storage.pools = EventLoopGroupConnectionPool(source: storage.source, on: application.eventLoopGroup)
    }

    func postgress(logger: Logger, on eventLoop: EventLoop) -> PostgresDatabase {
        let pool = storage.pools.pool(for: eventLoop)
        return pool.database(logger: logger)
    }

}
