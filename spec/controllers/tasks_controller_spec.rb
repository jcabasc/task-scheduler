require "rails_helper"

describe TasksController do
  describe "#create" do
    let(:params) { { task: task_params } }

    context "when successful" do
      let(:task_params) { { name: 'rspec', executable_path: '~/srv/.rspec', server: 'local', days_of_week: 'mon', started_at: Time.now + 1.hours, ended_at: Time.now + 5.hours } }
      it do
        post :create, params
        expect(flash[:notice]).to eq "The task was saved!"
        expect(response).to redirect_to task_path(controller.task)
      end
    end
    context "when unsuccesfull" do
      let(:task_params) { {  name: 'rspec', executable_path: '~/srv/.rspec', server: 'local', days_of_week: 'mon', started_at: Time.now, ended_at: Time.now  - 5.hours } }
      it do
        post :create, params
        expect(flash[:alert]).to eq "The task was not saved!"
        expect(response).to render_template "new"
      end
    end
  end
end