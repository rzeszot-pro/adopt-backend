import Auth
import XCTest

final class AuthorizeEmailTests: XCTestCase {
  var repo: InMemoryAccountRepository!
  var link: EmailLink!
  var account: UUID!

  var handler: AuthorizeEmailHandler!

  override func setUp() {
    repo = InMemoryAccountRepository()
    handler = AuthorizeEmailHandler(repository: repo)
    link = EmailLink(email: "user@example.org", password: "admin")
    account = UUID()
  }

  override func tearDown() {
    account = nil
    link = nil
    handler = nil
    repo = nil
  }

  // MARK: -

  func test_should_authorize_if_everything_ok() {
    repo.accounts = [account]
    repo.links[account] = link

    let query = AuthorizeEmailQuery.example
    let result = handler.handle(query: query)

    XCTAssertNotNil(result)
  }

  func test_should_not_authorize_if_no_account() {
    let query = AuthorizeEmailQuery.example
    let result = handler.handle(query: query)

    XCTAssertNil(result)
  }

  func test_should_not_authorize_if_no_email_auth() {
    let query = AuthorizeEmailQuery.example
    let result = handler.handle(query: query)

    XCTAssertNil(result)
  }
}

private extension AuthorizeEmailQuery {
  static var example: Self {
    .init(email: "user@example.org", password: "admin")
  }
}
