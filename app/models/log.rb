require 'active_resource'
class Log < ActiveResource::Base
    self.site = "http://localhost:4000/api/v1"
    self.include_root_in_json = true
end