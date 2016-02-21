require "rails_helper"

describe Api::V1::SessionsController do
  describe "post /api/v1/session" do
    let(:params) { {email: email, password: password} }
    let!(:user) { Fabricate(:user) }

    context "when success" do
      let(:email) { user.email }
      let(:password) { user.password }
      let(:json_response) { JSON.parse(response.body) }
      it "responds with status 200" do
        post "/api/v1/sessions", params
        expect(response).to be_success
        expect(response.status).to eq(200)
        expect(json_response["auth_token"] ).to eq(user.authentication_token)
      end
    end

    context "when failure" do
      let(:email) { user.email }
      let(:password) { "FakePaswword!" }
      let(:json_response) { JSON.parse(response.body) }
      it "responds with status 401" do
        post "/api/v1/auth/sign_in", params
        expect(response.status).to eq(401)
      end
    end
  end

  describe "#destroy" do
      let!(:user) { Fabricate(:user) }
      let(:json_response) { JSON.parse(response.body) }
      let(:params) { { auth_token: user.authentication_token } }

      it "responds with a successful response" do
        delete "/api/v1/auth/sign_out", params
        expect(json_response["success"]).to eq true
        expect(json_response["message"]).to eq("Token for user #{user.email} was reset successfully.")
      end
  end
end