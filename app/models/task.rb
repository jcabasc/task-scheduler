require 'active_resource'
class Task < ActiveResource::Base
    self.site = "http://localhost:4000/api/v1"
    self.include_root_in_json = true
    has_many :servers

    def ended_at
      Time.at(self.ended_at_int)
    end

    def started_at
      Time.at(self.started_at_int)
    end
end