import Vapor

var env = try Environment.detect()

try LoggingSystem.bootstrap(from: &env)

let app = Application(env)

// MARK: -

let auth = app.grouped("auth")

struct SignInRequest: Content {
    let user: String
    let password: String
}

struct SignInResponse: Content {
  let token: String
}

auth.post("sign-in") { req -> SignInResponse in
    let data = try req.content.decode(SignInRequest.self)
    return SignInResponse(token: "token-\(data.user)")
}

// MARK: -

app.get("hello") { req -> String in
    return "Hello, world!"
}

// MARK: -

app.get { req in
    return "It works!"
}

// MARK: -

defer {
  app.shutdown()
}

try app.run()
