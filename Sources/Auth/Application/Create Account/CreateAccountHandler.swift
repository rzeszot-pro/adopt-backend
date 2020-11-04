import Foundation

public struct CreateAccountHandler {
  public enum Error: Swift.Error {

  }

  private let repository: AccountRepository

  public init(repository: AccountRepository) {
    self.repository = repository
  }

  public func handle(command: CreateAccountCommand) -> Result<UUID, Error> {
    let uuid = repository.save(account: Account())
    return .success(uuid)
  }

  public func handle() -> Result<UUID, Error> {
    handle(command: CreateAccountCommand())
  }
}
