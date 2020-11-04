import Foundation

public struct LinkEmailToAccountCommand {
  public let account: UUID

  public let email: String
  public let password: String

  public init(account: UUID, email: String, password: String) {
    self.account = account
    self.email = email
    self.password = password
  }
}
