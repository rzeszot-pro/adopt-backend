import Auth
import XCTest

final class LinkEmailAuthToAccountTests: XCTestCase {
  var repo: InMemoryAccountRepository!
  var account: UUID!

  var handler: LinkEmailToAccountHandler!

  override func setUp() {
    account = UUID()
    repo = InMemoryAccountRepository()
    handler = LinkEmailToAccountHandler(repository: repo)
  }

  override func tearDown() {
    handler = nil
    repo = nil
    account = nil
  }

  // MARK: -

  func test_should_return_error_if_account_not_exist() {
    let command = LinkEmailToAccountCommand(account: UUID(), email: "user@example.org", password: "admin")
    let result = handler.handle(command: command)

    XCTAssertThrowsError(try result.get()) { error in
      XCTAssertEqual(error as? LinkEmailToAccountHandler.Error, .accountNotFound)
    }
  }

  func test_should_return_error_if_email_in_use() {
    repo.accounts = [ account ]
    repo.links[account] = EmailLink(email: "user@example.org", password: "email was taken")

    let command = LinkEmailToAccountCommand(account: account, email: "user@example.org", password: "admin")
    let result = handler.handle(command: command)

    XCTAssertThrowsError(try result.get()) { error in
      XCTAssertEqual(error as? LinkEmailToAccountHandler.Error, .emailAlreadyInUse)
    }
  }

  func test_should_add_entry_in_repository() {
    repo.accounts = [ account ]

    let command = LinkEmailToAccountCommand(account: account, email: "user@example.org", password: "admin")
    _ = handler.handle(command: command)

    XCTAssertNotNil(repo.links[account])
  }
}
