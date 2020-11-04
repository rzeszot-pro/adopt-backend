import Foundation

public struct LinkEmailToAccountHandler {
  private let repository: AccountLinkRepository

  public init(repository: AccountLinkRepository) {
    self.repository = repository
  }

  public enum Error: Swift.Error {
    case accountNotFound
    case emailAlreadyInUse
  }

  public func handle(command: LinkEmailToAccountCommand) -> Result<UUID, Error> {
    guard repository.find(by: command.email) == nil else { return .failure(.emailAlreadyInUse) }

    let link = EmailLink(email: command.email, password: command.password)

    return repository.attach(link: link, to: command.account)
      ? .success(command.account)
      : .failure(.accountNotFound)
  }
}
