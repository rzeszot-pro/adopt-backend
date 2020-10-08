//
//  Created by Damian Rzeszot on 08/10/2020.
//

import Foundation
import NIO

protocol UserRepository {
    func save(user: User) -> EventLoopFuture<UUID>
}
