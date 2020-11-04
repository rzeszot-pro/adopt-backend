import Foundation

public struct SignUpRequest {
  public let email: String
  public let password: String

  public init(email: String, password: String) {
    self.email = email
    self.password = password
  }
}
