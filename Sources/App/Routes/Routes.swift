import Vapor

extension Droplet {
  func setupRoutes() throws {
    get("hello") { req in
      var json = JSON()
      try json.set("hello", "world")
      return json
    }
    
    get("plaintext") { req in
      return "Hello, world!"
    }
    
    // response to requests to /info domain
    // with a description of the request
    get("info") { req in
      return req.description
    }
    
    get("description") { req in return req.description }
    
    get("name", String.parameter) { req in
      let name = try req.parameters.next(String.self)
      return "Hello \(name)!"
    }
    
    get("name2", ":name") { request in
      guard let name = request.parameters["name"]?.string else {
        throw Abort.badRequest
      }
      
      return "Hello \(name)!"
    }
    
    get("userid", ":id") { request in
      guard let userId = request.parameters["id"]?.int else {
        throw Abort.badRequest
      }
      
      return "Hello \(userId)!"
    }
    
    get("sayhello") { req in
      if let gender = req.data["gender"]?.string {
        return "Hello \(gender == "M" ? "Man" : "Lady")"
      }
      
      return "Hello"
    }
    
    get() { _ in
      return "Main"
    }
    
    try resource("posts", PostController.self)
  }
}
