import Foundation

public struct AuthorizeEmailHandler {
  private let repository: AccountLinkRepository

  public init(repository: AccountLinkRepository) {
    self.repository = repository
  }

  public func handle(query: AuthorizeEmailQuery) -> UUID? {
    let link = EmailLink(email: query.email, password: query.password)
    return repository.find(by: link)
  }
}
