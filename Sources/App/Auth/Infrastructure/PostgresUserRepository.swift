//
//  Created by Damian Rzeszot on 08/10/2020.
//

import Foundation
import PostgresKit

struct PostgresUserRepository: UserRepository {

    let postgres: PostgresDatabase

    func save(user: User) -> EventLoopFuture<UUID> {
        postgres
            .sql()
            .insert(into: "users")
            .columns("email")
            .values(user.email)
            .returning("uuid")
            .first()
            .map { try! $0!.decode(column: "uuid", as: UUID.self) }
    }
}
