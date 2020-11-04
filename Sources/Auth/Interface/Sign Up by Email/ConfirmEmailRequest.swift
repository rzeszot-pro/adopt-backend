import Foundation

public struct ConfirmEmailRequest {
  public let email: String
  public let code: String

  public init(email: String, code: String) {
    self.email = email
    self.code = code
  }
}
