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
      
      get("/name", ":name") { request in
        if let name = request.parameters["name"]?.string {
          return "Hello \(name)!"
        }
        return "Error retrieving parameters."
      }

        get("description") { req in return req.description }
        
        try resource("posts", PostController.self)
    }
}
