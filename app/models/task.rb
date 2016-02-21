class Task < ActiveRecord::Base
    has_and_belongs_to_many :servers
    validate :validate_dates
    validates :name, :days_of_week, :executable_path, presence: true

    def validate_dates
      if self.started_at > self.ended_at
        self.errors[:base] <<  "Start date can't be greater than Finish date"
      end
      if self.started_at < Time.now.getutc && self.new_record?
        self.errors[:base] << "Start date can't be less than current date"
      end
    end
end
