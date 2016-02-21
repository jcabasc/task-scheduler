require 'rails_helper'

RSpec.describe Task, type: :model do

  describe "#validations" do
    subject { Task.new(task_params) }
    before { subject.valid? }

    context "success" do
      let(:task_params) { { name: 'rspec', executable_path: '~/srv/.rspec', days_of_week: 'mon', started_at: Time.now + 1.hours, ended_at: Time.now + 5.hours } }
      its(:valid?) { should eq true }
      its("errors.full_messages.first") { should eq nil }
    end

    context "failure" do
      context "started_at > ended_at" do
        let(:task_params) { { name: 'rspec', executable_path: '~/srv/.rspec', days_of_week: 'mon', started_at: Time.now + 2.hours, ended_at: Time.now + 1.hours } }
        its(:valid?) { should eq false }
        its("errors.full_messages.first") { should eq "Start date can't be greater than Finish date" }
      end

      context "started_at < current time" do
        let(:task_params) { { name: 'rspec', executable_path: '~/srv/.rspec', days_of_week: 'mon', started_at: Time.now - 2.hours, ended_at: Time.now + 1.hours } }
        its(:valid?) { should eq false }
        its("errors.full_messages.first") { should eq "Start date can't be less than current date" }
      end

    end

  end
end
