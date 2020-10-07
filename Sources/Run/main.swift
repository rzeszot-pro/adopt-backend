import Vapor

var env = try Environment.detect()

try LoggingSystem.bootstrap(from: &env)

let app = Application(env)

// MARK: -

app.get { req in
    return "It works!"
}

app.get("hello") { req -> String in
    return "Hello, world!"
}



struct SignInRequest: Content {
    let user: String
    let password: String
}

struct SignInResponse: Content {
  let token: String
}


app.post("auth", "sign-in") { req -> SignInResponse in
    let data = try req.content.decode(SignInRequest.self)

    return SignInResponse(token: "token-\(data.user)")
}



// MARK: -

defer {
  app.shutdown()
}

try app.run()
