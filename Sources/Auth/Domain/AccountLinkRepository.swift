import Foundation

public struct EmailLink: Equatable {
  public let email: String
  public let password: String

  public init(email: String, password: String) {
    self.email = email
    self.password = password
  }
}

public protocol AccountLinkRepository {
  func attach(link: EmailLink, to account: UUID) -> Bool
  func confirm(email: String) -> Bool

  func find(by email: String) -> UUID?
  func find(by link: EmailLink) -> UUID?
}
