import Foundation

print("xxx")

//import Vapor
//import App
//import PostgresKit
//import JWT
//
//var env = try Environment.detect()
//try LoggingSystem.bootstrap(from: &env)
//
//let app = Application(env)
//app.middleware = .init()
//app.middleware.use(ErrorMiddleware.adopt(environment: env))
//
//try! app.wtf.use(url: "postgres://grtbtxpullvmew:8822e5703c63c3cd2308d7e8762f47244cdf44fe73b9be50ee1004e6b1810746@ec2-54-75-244-161.eu-west-1.compute.amazonaws.com:5432/ddt3kgl3r6pge8")
//
//app.jwt.signers.use(.hs256(key: "secret"))
//
////let db = app.wtf.postgress(logger: Logger(label: "xxx"), on: app.eventLoopGroup.next()).sql()
////
////db.raw(" CREATE EXTENSION \"uuid-ossp\";").run().wait()
////
////try! db
////    .drop(table: "users")
////    .ifExists()
////    .run()
////    .wait()
////
////
////try! db
////    .create(table: "users")
////    .column("uuid", type: .custom(SQLRaw("UUID")), .custom(SQLRaw("DEFAULT uuid_generate_v4()")))
////    .column("email", type: .text, .unique)
////    .column("password", type: .text)
////    .primaryKey("uuid")
////    .run()
////    .wait()
//
//
//CreateAccount().configure(app: app)
//
//// MARK: -
//
//app.get { req in
//    return "It works!"
//}
//
//// MARK: -
//
//defer {
//  app.shutdown()
//}
//
//try app.run()
