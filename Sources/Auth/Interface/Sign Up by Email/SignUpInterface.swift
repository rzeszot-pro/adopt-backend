import Foundation

public struct SignUpInterface {
  private let create: CreateAccountHandler
  private let link: LinkEmailToAccountHandler

  public init(create: CreateAccountHandler, link: LinkEmailToAccountHandler) {
    self.create = create
    self.link = link
  }

  public enum Error: Swift.Error {
    case emailAlreadyInUse
    case other
  }

  public func handle(request: SignUpRequest) -> Result<UUID, Error> {
    create.handle()
      .mapError(Error.init)
      .flatMap { uuid in
        link.handle(command: LinkEmailToAccountCommand(account: uuid, email: request.email, password: request.password)).mapError(Error.init)
      }
  }

  private func create(command: CreateAccountCommand) -> Result<UUID, Error> {
    create.handle(command: command).mapError(Error.init)
  }

  private func link(command: LinkEmailToAccountCommand) -> Result<UUID, Error> {
    link.handle(command: command).mapError(Error.init)
  }
}

private extension SignUpInterface.Error {
  init(_ error: CreateAccountHandler.Error) {
    self = .other
  }
  init(_ error: LinkEmailToAccountHandler.Error) {
    switch error {
    case .emailAlreadyInUse:
      self = .emailAlreadyInUse
    case .accountNotFound:
      self = .other
    }
  }
}
