//
//  Created by Damian Rzeszot on 08/10/2020.
//

import Foundation
import NIO

struct CreateUserHandler {
    let repository: UserRepository

    func handle(command: CreateUserCommand) -> EventLoopFuture<UUID> {
        repository.save(user: User(email: command.email))
    }
}
