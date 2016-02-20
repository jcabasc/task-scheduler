class Task < ActiveRecord::Base
    attr_accessor :started_at_date, :started_at_time, :ended_at_date, :ended_at_time
    validate :validate_dates
    validates :name, :server, :days_of_week, :executable_path, presence: true

    def validate_dates
      if self.started_at > self.ended_at
        self.errors[:base] <<  "Start date can't be greater than Finish date"
      end
      if self.started_at < Time.now.getutc && self.new_record?
        self.errors[:base] << "Start date can't be less than current date"
      end
    end
end
