import Auth
import XCTest

final class CreateAccountTests: XCTestCase {
  var repo: InMemoryAccountRepository!

  var handler: CreateAccountHandler!

  override func setUp() {
    repo = InMemoryAccountRepository()
    handler = CreateAccountHandler(repository: repo)
  }

  override func tearDown() {
    handler = nil
    repo = nil
  }

  // MARK: -

  func test_should_create_entry_in_repository() throws {
    let command = CreateAccountCommand()

    let result = handler.handle(command: command)
    let id = try result.get()

    XCTAssertEqual(repo.accounts.count, 1)
    XCTAssertEqual(repo.accounts.first, id)
  }
}
