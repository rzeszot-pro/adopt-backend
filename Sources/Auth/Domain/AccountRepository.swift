import Foundation

public struct Account {
  public init() {

  }
}

public protocol AccountRepository {
  func save(account: Account) -> UUID
  func exist(uuid: UUID) -> Bool
}
