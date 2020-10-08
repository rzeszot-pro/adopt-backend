import Vapor
import App
import PostgresKit

var env = try Environment.detect()
try LoggingSystem.bootstrap(from: &env)

let app = Application(env)


try! app.wtf.use(url: "xxx")


SignIn().configure(app: app)

// MARK: -

app.get { req in
    return "It works!"
}

// MARK: -

defer {
  app.shutdown()
}

try app.run()
