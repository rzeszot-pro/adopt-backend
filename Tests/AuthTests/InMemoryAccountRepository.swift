import Foundation
import Auth

class InMemoryAccountRepository {
  var accounts: Set<UUID> = []
  var links: [UUID: EmailLink] = [:]
}

extension InMemoryAccountRepository: AccountRepository {
  func save(account: Account) -> UUID {
    let id = UUID()
    accounts.insert(id)
    return id
  }

  func exist(uuid: UUID) -> Bool {
    accounts.contains(uuid)
  }
}

extension InMemoryAccountRepository: AccountLinkRepository {
  func confirm(email: String) -> Bool {
    false
  }

  func attach(link: EmailLink, to account: UUID) -> Bool {
    guard exist(uuid: account) else { return false }
    links[account] = link
    return true
  }

  func find(by email: String) -> UUID? {
    links.first { key, value in value.email == email }?.key
  }

  func find(by link: EmailLink) -> UUID? {
    links.first { key, value in value == link }?.key
  }
}
