require 'active_resource'
class Server < ActiveResource::Base
    self.site = "http://localhost:4000/api/v1"
end