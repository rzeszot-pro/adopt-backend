import Auth
import XCTest

final class SignUpInterfaceTests: XCTestCase {
  var repo: InMemoryAccountRepository!

  var interface: SignUpInterface!

  override func setUp() {
    repo = InMemoryAccountRepository()

    let account = CreateAccountHandler(repository: repo)
    let link = LinkEmailToAccountHandler(repository: repo)

    interface = SignUpInterface(create: account, link: link)
  }

  override func tearDown() {
    interface = nil
  }

  // MARK: -

  func test_interface_returns_account_uuid() {
    let request = SignUpRequest.example

    let result = interface.handle(request: request)

    XCTAssertNoThrow(try result.get())
  }

}

private extension SignUpRequest {
  static var example: Self {
    .init(email: "user@example.org", password: "admin")
  }
}
